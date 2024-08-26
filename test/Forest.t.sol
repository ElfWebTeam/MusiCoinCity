// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Test} from "forge-std/Test.sol";
import {Forest} from "../src/Forest.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract ForestTest is Test {
    Forest public forest;
    ERC20 public eduToken;

    address public mainWallet = 0x18a2E07cb2F4a3b6ef0DDEfe965819C6e32745d7;
    address public forestWallet = 0xC8bE450818D507b3a86E147726401D7fbED3340C;
    address public user = address(0x123);

    function setUp() public {
        eduToken = new ERC20("EDU Token", "EDU");
        forest = new Forest(address(eduToken));
        eduToken.transfer(user, 2000 * 10**18); // Mint some EDU tokens for testing
    }

    function test_DepositAndTransfer() public {
        vm.startPrank(user);
        eduToken.approve(address(forest), 2000 * 10**18);

        // Deposit below the threshold
        forest.deposit(500 * 10**18);
        assertEq(forest.getBalance(), 500 * 10**18);

        // Deposit to reach the threshold
        forest.deposit(500 * 10**18);
        assertEq(eduToken.balanceOf(mainWallet), 1000 * 10**18);
        assertEq(forest.getBalance(), 0);
    }

    function test_GetBalance() public {
        vm.startPrank(user);
        eduToken.approve(address(forest), 1000 * 10**18);

        forest.deposit(1000 * 10**18);
        assertEq(forest.getBalance(), 0); // Balance should be 0 after transfer
    }
}
