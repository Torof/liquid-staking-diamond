// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

struct User {
    uint stakes;
    uint lastInitTime;
    uint claimableRewards;
}

library PoolRewards {

    ///@notice is using diamond storage pattern see from {eip2535}

    bytes32 constant RewardsStorageSlot = keccak256("rewards.storage");

    uint constant VALIDATOR_CUT = 0;
    uint constant USER_CUT = 0;
    uint constant DAO_CUT = 0;
    uint constant DECIMALS_PRESERVATION = 1_000_000;

///@notice will be used by 4 contracts but should hold 1 accessible state for all
//Total Rewards
//Validator Rewards
//Users Rewards
//Protocol Rewards
struct RewardsStorage {
    mapping(address => User) users;
    uint[] weeklyAPR;
    uint poolInitTime;
    uint participants;
    
}

function rewardsStorage() internal pure returns (RewardsStorage storage rs) {
    bytes32 slot = RewardsStorageSlot;
        assembly {
            rs.slot := slot
        }
}

function receiveRewards() internal {}

function userReward() internal returns(uint){}

function updateRewards() internal {}

        //TODO: try/catch
    function _claim(address _user) internal returns (bool) {
        RewardsStorage storage rs = rewardsStorage();
        uint r = _calculateReward(rs.users[_user]);
        rs.users[_user].lastInitTime = block.timestamp;
        rs.users[_user].stakes = 0;
        (bool sent, ) = _user.call{value: r}("");
        require(sent, "ether not sent"); //PROD better message
        return true;
    }

    /**
     * @dev APR is calculated from the average of each week's APR
     * @notice the APR should be divided by 100 since it was multiplied by 100 to preserve 2 decimal points
     *
     */
    //ALERT years are not exactly 52 weeks. Use external oracle
    function _calculateReward(
        User memory _user
    ) internal view returns (uint reward) {
        require(block.timestamp - _user.lastInitTime > 0, "ovf"); //PROD better message
        uint duration = block.timestamp - _user.lastInitTime;
        uint averageAPR = _calculateAverageAPR(duration);
        reward =
            (((_user.stakes * averageAPR) / DECIMALS_PRESERVATION) /
                52 weeks) *
            duration;
    }

    /**
     * @dev APR is be multiplied by 1_000_000 to preserve decimal points.
     */
    function _calculateAverageAPR(
        uint _duration
    ) internal view returns (uint averageAPR) {
        RewardsStorage storage rs = rewardsStorage();
        require(rs.weeklyAPR.length > 0, "empty APR list"); //PROD better message
        
        uint numOfWeeks = _duration / 1 weeks;
        require(numOfWeeks == rs.weeklyAPR.length, "length mismatch");
        uint APRsum;
        uint length = rs.weeklyAPR.length;
        uint j = rs.weeklyAPR.length - numOfWeeks;
        for (uint i; i + j < length; ++i) {
            APRsum += rs.weeklyAPR[i + j];
        }

        averageAPR = ((APRsum * DECIMALS_PRESERVATION) / numOfWeeks);
    }
}