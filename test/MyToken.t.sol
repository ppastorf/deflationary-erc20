// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Test} from "forge-std/Test.sol";
import {MyToken} from "src/MyToken.sol";

contract MyTokenTest is Test {
  MyToken public instance;

  function setUp() public {
    address initialAuthority = vm.addr(1);
    instance = new MyToken(initialAuthority);
  }

  function testName() public view {
    assertEq(instance.name(), "MyToken");
  }
}
