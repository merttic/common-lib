// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "ERC721A-Upgradeable/extensions/ERC721AQueryableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";

import {AccessControlManager, AccessControlUpgradeable} from "../access/AccessControlUpgradeable.sol";

error WithdrawFailed();

abstract contract ERC721Base is
    Initializable,
    IERC721AUpgradeable,
    ERC721AQueryableUpgradeable,
    AccessControlManager,
    ReentrancyGuardUpgradeable
{
    //baseURI for the token metadata
    string public _metadataURI;
    string public _contractURI;

    event OwnerWithdrawn(uint256 amount);

    constructor() {
        _disableInitializers();
    }

    function _initialize(
        string memory _name,
        string memory _symbol,
        string memory baseUrl_,
        string memory _contractUri,
        address _owner
    ) internal {
        _metadataURI = baseUrl_;
        _contractURI = _contractUri;
        __ERC721A_init(_name, _symbol);
        __ERC721AQueryable_init();
        _transferOwnership(_owner);
        __ReentrancyGuard_init();
    }

    /**
     * @dev Base URI for computing {tokenURI}. If set, the resulting URI for each
     * token will be the concatenation of the `baseURI` and the `tokenId`. Empty
     * by default, it can be overridden in child contracts.
     */
    function _baseURI() internal view virtual override returns (string memory) {
        return _metadataURI;
    }

    function _startTokenId() internal view virtual override returns (uint256) {
        return 1;
    }

    function _checkOwnership(address owner, uint256[] memory tokens) internal view virtual returns (bool) {
        for (uint256 i = 0; i < tokens.length; ++i) {
            if (ownerOf(tokens[i]) != owner) {
                return false;
            }
        }
        return true;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(IERC721AUpgradeable, ERC721AUpgradeable, AccessControlUpgradeable)
        returns (bool)
    {
        return interfaceId == 0x01ffc9a7 // ERC165 interface ID for ERC165.
            || interfaceId == 0x80ac58cd // ERC165 interface ID for ERC721.
            || interfaceId == 0x5b5e139f || super.supportsInterface(interfaceId);
    }

    function withdraw() external onlyRole(GOVERNOR_ROLE) nonReentrant {
        uint256 balance = address(this).balance;
        (bool success,) = owner().call{value: balance}("");
        if (!success) revert WithdrawFailed();
        emit OwnerWithdrawn(balance);
    }
}
