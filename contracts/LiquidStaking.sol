// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/**
 * @notice:
 *
 */

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

/**
 * users send ETH, and receives liquid Tokens in a 1:1 ratio.
 * validators receives ETH
 *
 * quidETH is an erc20 token.
 */

using SafeERC20 for IERC20;

contract LiquidStaking is ERC20("quidETH", "qETH") {
    uint public constant DECIMALS_PRESERVATION = 1_000_000;
    uint totalStakes;
    uint private CUT;
    bool SHANGAI;
    uint[] public weeklyAPR;

    mapping(address => User) public users;

    struct User {
        uint totalUserStake;
        uint initTime;
    }

    //TODO add events
    event Claimed(uint indexed _amount, bool _sent);
    event AverageAPR(uint _numOfWeeks, uint _averageAPR);

    receive() external payable {}

    // =======================================
    //        STAKING & REWARDS
    // =======================================

    //ALERT until SHANGAÏ, unstaking is disallowed
    function unstake(uint _amount) external {
        require(SHANGAI, "shangai not released"); //PROD: better message
        require(users[msg.sender].totalUserStake - _amount >= 0, "underflow"); //PROD: better message
        users[msg.sender].totalUserStake -= _amount;
        _burn(msg.sender, _amount);
        bool claimed = claim();
        require(claimed, "not claimed"); //PROD better message
        (bool sent, ) = msg.sender.call{value: _amount}("");
        require(sent, "not sent"); //PROD better message
    }

    //CHECK set a minimum staking limit ?
    function stake() external payable {
        _mint(msg.sender, msg.value);
        users[msg.sender].totalUserStake += msg.value;
        totalStakes += msg.value;
        if (users[msg.sender].totalUserStake == 0) _claim(msg.sender);
    }

    function claim() public returns (bool claimed) {
        claimed = _claim(msg.sender);
    }

    //TODO only allowed contract or address can call
    //CHECK SET AN ADDRESS AND AUTOMATISE + PROTECT WITH MULTISIG DESIGNATED ADDRESS CHANGE ?
    /**
     * @dev SHOULD be multiplied by 100 to preserve decimal points
     */
    function pushWeekReward(uint _weekReward) external {
        weeklyAPR.push(_weekReward);
    }

    //TODO only allowed contract or address can call
    function openShangai() external {
        SHANGAI = true;
    }

    // ========================================
    //         INTERNAL
    // ========================================

        //TODO: try/catch
    function _claim(address _user) internal returns (bool) {
        uint r = _calculateReward(users[_user]);
        users[_user].initTime = block.timestamp;
        users[_user].totalUserStake = 0;
        (bool sent, ) = _user.call{value: r}("");
        require(sent, "ether not sent"); //PROD better message
        emit Claimed(r, sent);
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
        require(block.timestamp - _user.initTime > 0, "ovf"); //PROD better message
        uint duration = block.timestamp - _user.initTime;
        uint averageAPR = _calculateAverageAPR(duration);
        reward =
            (((_user.totalUserStake * averageAPR) / DECIMALS_PRESERVATION) /
                52 weeks) *
            duration;
    }

    /**
     * @dev APR should be multiplied by 100 to preserve 2 decimal points.
     */
    function _calculateAverageAPR(
        uint _duration
    ) internal view returns (uint averageAPR) {
        require(weeklyAPR.length > 0, "empty APR list"); //PROD better message
        uint numOfWeeks = _duration / 1 weeks;
        require(numOfWeeks == weeklyAPR.length, "length mismatch");
        uint APRsum;
        uint length = weeklyAPR.length;
        uint j = weeklyAPR.length - numOfWeeks;
        for (uint i; i + j < length; ++i) {
            APRsum += weeklyAPR[i + j];
        }

        averageAPR = ((APRsum * DECIMALS_PRESERVATION) / numOfWeeks);
    }

    // ========================================
    //         VIEW
    // ========================================

    function displayReward(address _user) public view returns (uint reward) {
        reward = _calculateReward(users[_user]);
    }

    function displayStakeTime(address _user) public view returns (uint st) {
        st = block.timestamp - users[_user].initTime;
    }

}
