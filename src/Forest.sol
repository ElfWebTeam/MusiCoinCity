// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract Forest {
    address public mainWallet = 0x18a2E07cb2F4a3b6ef0DDEfe965819C6e32745d7;
    address public forestWallet = 0xC8bE450818D507b3a86E147726401D7fbED3340C;
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
