// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract Ocean {
    address public mainWallet = 0x18a2E07cb2F4a3b6ef0DDEfe965819C6e32745d7;
    address public oceanWallet = 0x7487F839C3b827A74192AB79266Ff15502Dc3298;
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
