// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";

abstract contract AccessControlManager is AccessControlUpgradeable, OwnableUpgradeable {
    bytes32 internal constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 internal constant BURNER_ROLE = keccak256("BURNER_ROLE");
    bytes32 internal constant GOVERNOR_ROLE = keccak256("GOVENOR_ROLE");

    function _setGovernor(address _governor) internal onlyOwner {
        _grantRole(GOVERNOR_ROLE, _governor);
    }

    function isGovernor() internal view returns (bool) {
        return hasRole(GOVERNOR_ROLE, msg.sender) || owner() == msg.sender;
    }

    function setGovernor(address governor) public virtual onlyOwner {
        _setGovernor(governor);
    }
}
