// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

struct UserAllInfo {
    bytes32[] userPools;
    uint256 totalStakes;
}

struct PoolInfo {
 bytes32 identifier;
}

library LibPoolTower {
    bytes32 constant PoolTowerStorageSlot =  keccak256("pool.tower.storage");

    struct PoolTowerStorage {
        uint256 allStakes;
        bytes32[] poolIdentifiers;
        mapping(address => UserAllInfo) usersInfoForAll;
        mapping(bytes32 => PoolInfo) allPools;
    }

    function poolTowerStorage() internal pure returns(PoolTowerStorage storage pls){
        bytes32 slot = PoolTowerStorageSlot;
        assembly {
            pls.slot := slot
        }
    }

}