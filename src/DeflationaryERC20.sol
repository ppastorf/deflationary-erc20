// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

interface IDeflationaryERC20 {
    event Burn(address indexed account, uint256 amount);
    event UpdateBurnPercentage(uint256 oldPercentage, uint256 newPercentage);

    function burnPercentage() external view returns (uint256);
    function setBurnPercentage(uint256 _newPercentage) external;
}

abstract contract DeflationaryERC20 is IDeflationaryERC20, ERC20 {
    /**
     * @dev Precision for calculations with uint values. 
     * If _percentPrecision = 10 000; then
     *        10 000 = 100%
     *         1 000 = 10%
     *           100 = 1%
     *            10 = 0.1%
     *             1 = 0.01%
     */
    uint256 public percentPrecision;


    // percent to be burned on transactions given from 0 to _percentPrecision
    uint256 public burnPercentage;

    constructor(uint256 _percentPrecision, uint256 _burnPercentage) {
        percentPrecision = _percentPrecision;
        _setBurnPercentage(_burnPercentage);
    }

    /**
     * @dev Sets the burn percentage given percentPrecision;
     */
    function _setBurnPercentage(uint256 _newPercentage) internal {
        require(_newPercentage <= percentPrecision, "_newPercentage must be between 0 and _percentPrecision");

        uint256 oldPercentage = burnPercentage;
        burnPercentage = _newPercentage;
        emit UpdateBurnPercentage(oldPercentage, burnPercentage);
    }

    /**
     * @dev Calculate burn amount given the set precision and percentage
     */
    function _calcBurnAmount(uint256 amount) internal view returns (uint256) {
        return Math.mulDiv(amount, burnPercentage, percentPrecision);
    }

    /**
        override method transfer(address,uint256) from ERC20
     */
    function transfer(address to, uint256 value) public virtual override returns (bool) {
        address owner = _msgSender();

        // Calculate amount to be burned and to be sent
        uint256 burned = _calcBurnAmount(value);
        (bool success, uint256 sent) = Math.trySub(value, burned);
        require(success, "Overflow calculating sent and burned amount");

        // Burn given amount
        _burn(owner, burned);
        emit Burn(owner, burned);

        // Transfer remainder
        _transfer(owner, to, sent);
        return true;
    }

    /**
        override method transferFrom(address,address,uint256) from ERC20
     */
    function transferFrom(address from, address to, uint256 value) public virtual override returns (bool) {
        address spender = _msgSender();

        // Calculate amount to be burned and to be sent
        uint256 burned = _calcBurnAmount(value);
        (bool success, uint256 sent) = Math.trySub(value, burned);
        require(success, "Overflow calculating sent and burned amount");

        // Remove the total value from allowances
        _spendAllowance(from, spender, value);

        // Burn given amount
        _burn(from, burned);
        emit Burn(from, burned);

        // Transfer remainder
        _transfer(from, to, sent);
        return true;
    }
}
