//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.16;

import "../interfaces/IDeployer.sol";

contract ZkCreate2Deployer {

    event Deployed(address addr, bytes32 salt);
    ICreate2Deployer public contractDeployer;

    constructor(address _contractDeployer) {
        contractDeployer = ICreate2Deployer(_contractDeployer);
    }

    function deploy(bytes memory code, bytes32 data, bytes32 salt) public returns (address) {
        address addr = contractDeployer.create2(salt, data, code);
        require(addr != address(0), "Deployment failed");
        emit Deployed(addr, salt);
        return addr;
    }
}