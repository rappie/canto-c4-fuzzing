// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Tray} from "../../Tray.sol";

contract MockTray is Tray {
    constructor(
        bytes32 _initHash,
        uint256 _trayPrice,
        address _revenueAddress,
        address _note,
        address _namespaceNFT
    ) Tray(_initHash, _trayPrice, _revenueAddress, _note, _namespaceNFT) {}

    function nextTokenId() external view returns (uint256) {
        return _nextTokenId();
    }

    function setLastHash(bytes32 _lastHash) external {
        lastHash = _lastHash;
    }

    function setNamespace(address _namespaceNFT) external {
        namespaceNFT = _namespaceNFT;
    }

    function exists(uint _tokenId) external view returns (bool) {
        return _exists(_tokenId);
    }
}
