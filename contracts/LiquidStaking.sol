// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/**
 * @notice: 
 * 
 */
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
//TODO: change to safeERC20

/**
 * users send ETH, and receives liquid Tokens in a 1:1 ratio.
 * validators receives ETH
 * 
 * quidETH is an erc20 token.
 */

using SafeERC20 for ERC20;

contract LiquidStaking is ERC20("quidETH","qETH"){
    struct User {
        uint stakedETH;
        uint timeStamp;
    }

    struct Validator{
        Status status;
        address[] stakers;
    }

    enum Status {
        PENDING,FULL,CLOSE
    }

    mapping(address => User) private stakes;
    Validator[] validators;

    receive() external payable {
        stakes[msg.sender].timeStamp = block.timestamp;
        stakes[msg.sender].stakedETH += msg.value;
        _mint(msg.sender, msg.value);
    }

    function unstake(uint _amount) external {
        require(balanceOf(msg.sender) >= _amount, "not enough balance");
        _burn(msg.sender, _amount);
        uint reward = _reward(stakes[msg.sender]);
        (bool sent,) = msg.sender.call{value: _amount + reward}("");   //!\\
        require(sent, "not sent");
    }

    //sets a hardcoded 4.5 APR
    //ALERT: years are not exactly 52 weeks. Use external oracle
    function _reward(User memory _user) internal view returns (uint reward){
        uint duration = block.timestamp - _user.timeStamp;
        reward = (_user.stakedETH  * 45 / 1000) / 52 weeks * duration ;
    }



    
}