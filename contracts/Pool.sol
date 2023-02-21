// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

import "./security/Lock.sol";

contract Pool is Lock{
    //A pool is tied to a validator
    //Pool receives funds
    //Pool receives rewards
    //users' lock for minimum deposit time
    //Keep track of Pool stats
    //use library

    uint totalStakes;
    uint participants;
    address immutable VALIDATOR;
    bytes32 immutable IDENTIFIER;
    string NAME;
    mapping(address => bool) isParticipant;

    // struct PoolInfo{
    //     bytes32 identifier;
    //     string name;
    //     uint stakes;
    //     uint participants;
    // }

    constructor(address _VALIDATOR, string memory _poolName) payable {
        VALIDATOR = _VALIDATOR;
        NAME = _poolName;
        IDENTIFIER = bytes32(abi.encode(_VALIDATOR, _poolName, block.timestamp));
    }



}