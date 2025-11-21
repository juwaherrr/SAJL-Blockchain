// SPDX-License-Identifier: MIT
// TAG: deploy_v2 – idempotent & repeatable deployment script

pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/SajlRegistry.sol";

contract Deploy_v2 is Script {
    function run() external {
        vm.startBroadcast();

        // Same three fixed family addresses used in Sprint 4
        new SajlRegistry(
            0xE35b657992cf1877fc3673c2Bdc273F39317Ae5f,
            0xf044efbea6857b7430d7d48b0f6242c43e27255c,
            0x675308af4063fba11d49d323bcc138cb79286e51
        );

        vm.stopBroadcast();
    }
}
