// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

interface IStaking {

    function deposit() external payable;
    function withdraw() external;
    function claim() external;
    //events
    /**
     * deposit
     * withdraw
     * rewards distributed
     * liquid collateral minted
     * liquid collateral burned
     */

    //function headers
    /**
     * deposit
     * withdraw
     * mint liquid collateral (ERC20)
     * burn liquid collateral
     * claim
     */
}