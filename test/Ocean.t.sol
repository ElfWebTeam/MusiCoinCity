// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Test} from "forge-std/Test.sol";
import {Ocean} from "../src/Ocean.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract OceanTest is Test {
    Ocean public ocean;
    ERC20 public eduToken;

    address public mainWallet = 0x18a2E07cb2F4a3b6ef0DDEfe965819C6e32745d7;
    address public oceanWallet = 0x7487F839C3b827A74192AB79266Ff15502Dc3298;
    address public user = address(0x123);

    function setUp() public {
        eduToken = new ERC20("EDU Token", "EDU");
        ocean = new Ocean(address(eduToken));
        eduToken.transfer(user, 2000 * 10**18); // Mint some EDU tokens for testing
    }

    function test_DepositAndTransfer() public {
        vm.startPrank(user);
        eduToken.approve(address(ocean), 2000 * 10**18);

        // Deposit below the threshold
        ocean.deposit(500 * 10**18);
        assertEq(ocean.getBalance(), 500 * 10**18);

        // Deposit to reach the threshold
        ocean.deposit(500 * 10**18);
        assertEq(eduToken.balanceOf(mainWallet), 1000 * 10**18);
        assertEq(ocean.getBalance(), 0);
    }

    function test_GetBalance() public {
        vm.startPrank(user);
        eduToken.approve(address(ocean), 1000 * 10**18);

        ocean.deposit(1000 * 10**18);
        assertEq(ocean.getBalance(), 0); // Balance should be 0 after transfer
    }
}
