// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

import "./security/Lock.sol";

contract Pool is Lock{
    //A pool is tied to a validator
    //users' lock for minimum deposit time

    struct User {
        uint stake;
    }

    struct Share {
        uint share;
    }

}