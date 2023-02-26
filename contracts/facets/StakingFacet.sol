// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
 * @notice:
 *
 */


import "./interfaces/IStaking.sol";
import "../LiquidToken.sol";
import "./facets/PoolTower.sol";

/**
 * users send ETH, and receives liquid Tokens in a 1:1 ratio.
 * validators receives ETH
 *
 * quidETH is an erc20 token.
 */


contract StakingFacet is LiquidToken {
    bool SHANGAI;


    //TODO add events
    event Claim(uint indexed _amount, bool _sent);
    event Deposit();
    event Withdraw();

    receive() external payable {}

    fallback() external payable {}

    // =======================================
    //        STAKING & REWARDS
    // =======================================

    function enter(address _poom) external payable {

    }

        //CHECK set a minimum staking limit ?
    function deposit(address _pool) external payable {

    }



    //ALERT until SHANGAÏ, unstaking is disallowed
    function withdraw(uint _amount, address _pool) external {

    }

    function exit(address _pool) external {
        
    }


    function claim() public returns (bool claimed) {
    }


    //TODO only allowed contract or address can call
    function openShangai() external {
        SHANGAI = true;
    }

    // ========================================
    //         VIEW
    // ========================================

    function displayReward(address _user) public view returns (uint reward) {}

    function displayStakeTime(address _user) public view returns (uint st) {}

}

