// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract Space {
    address public mainWallet = 0x18a2E07cb2F4a3b6ef0DDEfe965819C6e32745d7;
    address public spaceWallet = 0x998ca7E5a4bD0D83141a2024b14A527E35A49A56;
    uint256 public constant transferThreshold = 1000 * 10**18; // 1000 EDU (18 decimals)

    ERC20 public eduToken;

    constructor(address _eduTokenAddress) {
        eduToken = ERC20(_eduTokenAddress);
    }

    function deposit(uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        eduToken.transferFrom(msg.sender, address(this), amount);
        if (eduToken.balanceOf(address(this)) >= transferThreshold) {
            transferToMainWallet();
        }
    }

    function transferToMainWallet() internal {
        uint256 balance = eduToken.balanceOf(address(this));
        require(balance >= transferThreshold, "Insufficient balance to transfer");

        eduToken.transfer(mainWallet, balance);
    }

    function getBalance() public view returns (uint256) {
        return eduToken.balanceOf(address(this));
    }
}
