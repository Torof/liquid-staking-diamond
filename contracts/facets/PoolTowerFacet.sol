// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

contract PoolTowerFacet {
    //Keep track of all pools
    //keep track of the pools a user has stakes in
    //Keep track of all app stakes and stats
    //access a specific pool stats
    //register new pool

    struct UserMain {
        uint totalUserStake;
        bytes32[] pools;
    }

    struct PoolInfo{
        bytes32 identifier;
        string name;
        uint stakes;
        uint participants;
    }

    uint allStakes;
    mapping(address => UserMain) usersInfoForAll;
    mapping(bytes32 => PoolInfo) allPools;
    bytes32[] poolIdentifiers;
}