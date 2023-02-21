// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

contract PoolTower {
    //Keep track of all pools
    //keep track of the pools a user has stakes
    //Keep track of all app stakes and stats
    //access a specific pool stats
    //register new pool

    struct User {
        uint totalUserStake;
        address[] pools;
    }

    uint allStakes;

    mapping(address => User) userPoolInfo;
    address[] pools;
}