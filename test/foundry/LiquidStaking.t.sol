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
        _amount = _amount * 1 ether;
        vm.deal(bob, (_amount + 1 ether));
        vm.prank(bob);
        _ls = ls;
        _ls.deposit{value: 10 ether}();
        emit log_named_uint("bobBalance", bob.balance);
        emit log_named_uint("contractBalance", address(this).balance);
    }

    function testStaking() public payable{
        LiquidStaking _ls = staking(10);
        emit log_named_uint("bobBalance2", _ls.balanceOf(bob));
        assertEq(_ls.balanceOf(bob), 10 ether);
    }

    //TODO fail unstaking shangai false
    // function testFailUnstaking1() external {

    // }

    //TODO fail indexOutOfbond
    // function testFailUnstaking2() external {
        
    // }

    function testUnstaking() external {
        LiquidStaking _ls = staking(10);
        assertEq(_ls.balanceOf(bob), 10 ether);
        for(uint i; i < 28; ++i){
            ls.pushWeekReward(450);
        }
        skip(8 weeks);
        _ls.openShangai();
        skip(20 weeks);
        emit log_named_uint("duration",_ls.displayStakeTime(bob));
        emit log_named_uint("numOfweeks",ls.displayStakeTime(bob) / 1 weeks);
        emit log_named_uint("bobReward", _ls.displayReward(bob));
        assertEq(_ls.balanceOf(bob), 10 ether);
        vm.prank(bob);
        _ls.withdraw(10 ether);
        emit log_named_uint("bobReward", _ls.balanceOf(bob));
        assertEq(_ls.balanceOf(bob), 0);
        // assertGt(bob.balance , bobBalanceBeforeUnstaking);
        // assertGt(bob.balance , 11 ether);
        // emit log_uint(bobBalanceBeforeUnstaking);
        emit log_uint(bob.balance);
    }
    
}