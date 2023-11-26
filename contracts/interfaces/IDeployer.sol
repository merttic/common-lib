// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.20;

interface ICreate2Deployer {
    function create2(bytes32 _salt, bytes32 _bytecodeHash, bytes calldata _input)
        external
        payable
        returns (address newAddress);
}
