// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.16;

struct UserAllInfo {
    bytes32[] userPools;
    uint256 totalStakes;
}

struct PoolInfo {

}

library LibPoolTower {
    bytes32 PoolTowerStorageSlot =  keccak256("pool.tower.storage");

    struct PoolTowerStorage {
        uint256 allStakes;
        bytes32[] poolIdentifiers;
        mapping(address user => UserAllInfo info) usersInfoForAll;
        mapping(bytes32 identifier => PoolInfo pool) allPools;
    }

    function poolTowerStorage() internal returns(PoolTowerStorage storage pls){
        bytes32 slot = PoolTowerStorageSlot;
        assembly {
            pls.slot := slot;
        }
    }

}