// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

import {DeflationaryERC20} from "./DeflationaryERC20.sol";

contract DeflateCoin is ERC20, DeflationaryERC20, Ownable {
    constructor() 
        ERC20("Deflate1", "DEFL1")
        Ownable(msg.sender)
        DeflationaryERC20(10000, 5) // = 0,05%
    {}

    /**
     *  Must specify to use DeflationaryERC20 transfer functions
     */

    function transfer(address to, uint256 value) public override(ERC20, DeflationaryERC20) returns (bool) {
        return DeflationaryERC20.transfer(to, value);
    }

    function transferFrom(address from, address to, uint256 value) public  override(ERC20, DeflationaryERC20) returns (bool) {
        return DeflationaryERC20.transferFrom(from, to, value);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function setBurnPercentage(uint256 _newPercentage) public onlyOwner {
        _setBurnPercentage(_newPercentage);
    }
}