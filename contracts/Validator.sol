// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

import "./Pool.sol";

contract Validator {
    //Holds a validator info (balance, identifier, pools, stats)
    //Track validators performance
    //Verify appropriate balance
    //Init staking pool

    address immutable VALIDATOR_ADDRESS;

    struct ValidatorStats {
        bytes32 identifier;
    }

    constructor(address _validator) {
        VALIDATOR_ADDRESS =_validator;
    }

}