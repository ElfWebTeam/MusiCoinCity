// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Test} from "forge-std/Test.sol";
import {Desert} from "../src/Desert.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract DesertTest is Test {
    Desert public desert;
    ERC20 public eduToken;

    address public mainWallet = 0x18a2E07cb2F4a3b6ef0DDEfe965819C6e32745d7;
    address public desertWallet = 0x1820774Fa7F7e7bb810588300A38Aaa5E4FD301c;
    address public user = address(0x123);

    function setUp() public {
        eduToken = new ERC20("EDU Token", "EDU");
        desert = new Desert(address(eduToken));
        eduToken.transfer(user, 2000 * 10**18); // Mint some EDU tokens for testing
    }

    function test_DepositAndTransfer() public {
        vm.startPrank(user);
        eduToken.approve(address(desert), 2000 * 10**18);

        // Deposit below the threshold
        desert.deposit(500 * 10**18);
        assertEq(desert.getBalance(), 500 * 10**18);

        // Deposit to reach the threshold
        desert.deposit(500 * 10**18);
        assertEq(eduToken.balanceOf(mainWallet), 1000 * 10**18);
        assertEq(desert.getBalance(), 0);
    }

    function test_GetBalance() public {
        vm.startPrank(user);
        eduToken.approve(address(desert), 1000 * 10**18);

        desert.deposit(1000 * 10**18);
        assertEq(desert.getBalance(), 0); // Balance should be 0 after transfer
    }
}
