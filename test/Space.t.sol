// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Test} from "forge-std/Test.sol";
import {Space} from "../src/Space.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract SpaceTest is Test {
    Space public space;
    ERC20 public eduToken;

    address public mainWallet = 0x18a2E07cb2F4a3b6ef0DDEfe965819C6e32745d7;
    address public spaceWallet = 0x998ca7E5a4bD0D83141a2024b14A527E35A49A56;
    address public user = address(0x123);

    function setUp() public {
        eduToken = new ERC20("EDU Token", "EDU");
        space = new Space(address(eduToken));
        eduToken.transfer(user, 2000 * 10**18); // Mint some EDU tokens for testing
    }

    function test_DepositAndTransfer() public {
        vm.startPrank(user);
        eduToken.approve(address(space), 2000 * 10**18);

        // Deposit below the threshold
        space.deposit(500 * 10**18);
        assertEq(space.getBalance(), 500 * 10**18);

        // Deposit to reach the threshold
        space.deposit(500 * 10**18);
        assertEq(eduToken.balanceOf(mainWallet), 1000 * 10**18);
        assertEq(space.getBalance(), 0);
    }

    function test_GetBalance() public {
        vm.startPrank(user);
        eduToken.approve(address(space), 1000 * 10**18);

        space.deposit(1000 * 10**18);
        assertEq(space.getBalance(), 0); // Balance should be 0 after transfer
    }
}
