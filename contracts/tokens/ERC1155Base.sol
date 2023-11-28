// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {ERC1155Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import {ReentrancyGuardUpgradeable} from "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
import {AccessControlManager, AccessControlUpgradeable} from "../access/AccessControlUpgradeable.sol";

error WithdrawFundFailed();

abstract contract ERC1155Base is ERC1155Upgradeable, AccessControlManager, ReentrancyGuardUpgradeable {
    event OwnerWithdrawn(uint256 amount);

    function _initialize(address _owner, string memory _uri) internal {
        __ERC1155_init(_uri);
        _transferOwnership(_owner);
        __ReentrancyGuard_init();
    }

    function burn(address account, uint256 id, uint256 value) public virtual {
        require(account == _msgSender() || isGovernor(), "ERC1155: caller is not token owner nor approved");

        _burn(account, id, value);
    }

    function burnBatch(address account, uint256[] memory ids, uint256[] memory values) public virtual {
        require(account == _msgSender() || isGovernor(), "ERC1155: caller is not token owner nor approved");
        _burnBatch(account, ids, values);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC1155Upgradeable, AccessControlUpgradeable)
        returns (bool)
    {
        return interfaceId == type(ERC1155Base).interfaceId || super.supportsInterface(interfaceId);
    }

    function withdraw() external nonReentrant {
        uint256 balance = address(this).balance;
        address payable owner = payable(owner());
        (bool success,) = owner.call{value: balance}("");
        if (!success) revert WithdrawFundFailed();
        emit OwnerWithdrawn(balance);
    }
}
