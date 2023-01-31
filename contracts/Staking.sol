// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/**
 * @notice:
 *
 */

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./interfaces/IStaking.sol";
import "./LiquidToken.sol";
import "./PoolManager.sol";
import {PoolRewards} from "./libraries/PoolRewards.sol";

/**
 * users send ETH, and receives liquid Tokens in a 1:1 ratio.
 * validators receives ETH
 *
 * quidETH is an erc20 token.
 */


contract Staking is LiquidToken {
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

        //CHECK set a minimum staking limit ?
    function deposit() external payable {

    }

    //ALERT until SHANGAÏ, unstaking is disallowed
    function withdraw(uint _amount) external {

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

