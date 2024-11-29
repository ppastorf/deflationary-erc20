// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {AccessManaged} from "@openzeppelin/contracts/access/manager/AccessManaged.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MyToken is ERC20, ERC20Permit, AccessManaged {
    constructor(address initialAuthority)
        ERC20("MyToken", "MTK")
        ERC20Permit("MyToken")
        AccessManaged(initialAuthority)
    {}
}
