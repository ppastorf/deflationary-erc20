// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {MyToken} from "src/MyToken.sol";

contract MyTokenScript is Script {
  function setUp() public {}

  function run() public {
    // TODO: Set addresses for the variables below, then uncomment the following section:
    /*
    vm.startBroadcast();
    address initialAuthority = <Set initialAuthority address here>;
    MyToken instance = new MyToken(initialAuthority);
    console.log("Contract deployed to %s", address(instance));
    vm.stopBroadcast();
    */
  }
}
