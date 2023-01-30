// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

library Rewards {

    ///@notice is using diamond storage pattern see from {eip2535}

bytes32 constant RewardsStorageSlot = keccak256("RewardsStorage");

///@notice will be used by 4 contracts but should hold 1 accessible state for all
//Total Rewards
//Validator Rewards
//Users Rewards
//Protocol Rewards
struct RewardsStorage {
    mapping(address => mapping(bool => uint)) userRewards;
    uint validatorCut;
    uint userCut;
    uint DAOcut;
}

function rewardsStorage() internal pure returns (RewardsStorage storage rs) {
    bytes32 slot = RewardsStorageSlot;
        assembly {
            rs.slot := slot
        }
}

function receiveRewards() internal {}

function userReward() internal returns(uint){}
}