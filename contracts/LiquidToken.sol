// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

// import "./interfaces/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

using SafeERC20 for IERC20;

contract LiquidToken is ERC20("quidETH", "qETH"){

    modifier contractOnly() {
        require(msg.sender == address(this));
        _;
    }

}