
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/SajlRegistry.sol";

contract Deploy is Script {
    function run() external {
        // Start broadcasting using the first Anvil account
        vm.startBroadcast();

        // Deploy the SajlRegistry contract with the 3 constructor addresses
        SajlRegistry registry = new SajlRegistry(
            0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266,
            0x70997970C51812dc3A010C7d01b50e0d17dc79C8,
            0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
        );

        vm.stopBroadcast();
    }
}


