// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

import "./security/Lock.sol";
import "./libraries/PoolRewards.sol";

contract Pool is Lock {
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

    constructor(address _VALIDATOR, string memory _poolName) payable {
        require(msg.value == 32 ether, "creation amount is 32");
        VALIDATOR = _VALIDATOR;
        NAME = _poolName;
        IDENTIFIER = bytes32(abi.encode(_VALIDATOR, _poolName, block.timestamp));
    }

    function deposit() external {}

    function withdraw() external {}

    function claim() external {}

    function returnRemainingLockTime(address _user) external {}



}