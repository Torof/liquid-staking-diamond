// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

import "./security/Lock.sol";

contract Pool is Lock{
    //A pool is tied to a validator
    //Pool receives funds
    //users' lock for minimum deposit time
    //Keep track of Pool stats
    //use library

    uint totalStakes;
    address immutable poolManager;

    constructor(address _poolManager){
        poolManager = _poolManager;
    }



}