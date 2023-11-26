// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.20;

interface IUpgradeable {
    /**
     * @notice Contract version number.
     *
     * @return uint256 The version number.
     */
    function version() external pure returns (uint256);
}
