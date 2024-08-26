// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import {Desert} from "../src/Desert.sol";

contract ForestScript is Script {
    function run() public {
        address eduTokenAddress = 0x77721D19BDfc67fe8cc46ddaa3cc4C94e6826E3C; // EDU token contract address

        vm.startBroadcast();

        new Desert(eduTokenAddress);

        vm.stopBroadcast();
    }
}
