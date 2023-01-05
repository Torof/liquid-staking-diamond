// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "contracts/LiquidStaking.sol";

contract LiquidStakingTest is Test, LiquidStaking {

    LiquidStaking ls;
    address bob = makeAddr("bob");
    address alice = makeAddr("alice");
    address tom = makeAddr("tom");
    address matt = makeAddr("matt");

    function setUp() external {
        ls = new LiquidStaking();
        // address bob = vm.addr(0);
        // address alice = vm.addr(1);
        // address tom = vm.addr(2);
        // address matt = vm.addr(3);

    }

    function staking(uint _amount) public returns (LiquidStaking _ls){
        vm.prank(bob);
        vm.deal(bob, (_amount * 1 ether));
        (bool sent,) = address(ls).call{value: 10 ether}("");
        require(sent);
        _ls = ls;
    }
    function testStaking() public payable{
        LiquidStaking _ls = staking(11);
        assertEq(_ls.balanceOf(bob), 10 ether);
    }

    function testUnstaking() external {
        LiquidStaking _ls = staking(11);
        assertEq(_ls.balanceOf(bob), 10 ether);
        skip(8 weeks);
        vm.deal(address(_ls), 100 ether);
        vm.prank(bob);
        _ls.unstake(10 ether);
        assertEq(_ls.balanceOf(bob), 0);
        assertGt(bob.balance , 11);
        emit log_uint(bob.balance);
    }

    
}