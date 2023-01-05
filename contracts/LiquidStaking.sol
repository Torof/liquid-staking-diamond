// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/**
 * @notice: 
 * 
 */
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

/**
 * users send ETH, and receives liquid Tokens in a 1:1 ratio.
 * validators receives ETH
 * 
 * quidETH is an erc20 token.
 */

using SafeERC20 for IERC20;

contract LiquidStaking is ERC20("quidETH","qETH"){

    struct User {
        uint totalStake;
        uint initTime;
    }


    mapping(address=> User) users;


   
    receive() external payable {
        _mint(msg.sender, msg.value);
    }

    function unstake(uint _amount) external {
        require(balanceOf(msg.sender) >= _amount, "not enough balance");
        _burn(msg.sender, _amount);
        (bool sent,) = msg.sender.call{value: _amount}("");
        require(sent);
    }

    //sets a hardcoded 4.5 APR
    //ALERT: years are not exactly 52 weeks. Use external oracle
    function _reward(User memory _user) internal view returns (uint finalReward){
        uint duration = block.timestamp - _user.initTime;
        uint reward = (_user.totalStake  * 45 / 1000) / 52 weeks * duration ;
        uint cut = reward *10 /100;
        finalReward = reward - cut;
    }

    function claim() external returns(bool){
        uint r =_reward(users[msg.sender]);
        users[msg.sender].initTime = block.timestamp;
        (bool sent,) = msg.sender.call{value: r}("");
        require(sent);
        return true;
    }



    
}