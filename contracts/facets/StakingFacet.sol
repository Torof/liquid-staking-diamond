// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
 * @notice:
 *
 */

import "../interfaces/IStaking.sol";
import "../LiquidToken.sol";
import "./PoolTowerFacet.sol";

/**
 * users send ETH, and receives liquid Tokens in a 1:1 ratio.
 * validators receives ETH
 *
 * quidETH is an erc20 token.
 */

contract StakingFacet is LiquidToken {
    //TODO add events
    event Claim(uint256 indexed _amount, bool _sent);
    event Deposit();
    event Withdraw();

    receive() external payable {}

    fallback() external payable {}

    // =======================================
    //        STAKING & REWARDS
    // =======================================

    function enter(address _pool) external payable {}

    //CHECK set a minimum staking limit ?
    function depositTo(address _pool) external payable {}

    //ALERT until SHANGAÏ, unstaking is disallowed
    function withdrawFrom(uint256 _amount, address _pool) external {}

    function exit(address _pool) external {}

    function claimFrom() public returns (bool claimed) {}

    // ========================================
    //         VIEW
    // ========================================

    function displayReward(
        address _user
    ) public view returns (uint256 reward) {}

    function displayStakeTime(address _user) public view returns (uint256 st) {}
}
