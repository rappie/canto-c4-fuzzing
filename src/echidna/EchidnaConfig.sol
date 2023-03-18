// SPDX-License-Identifier: MIT

contract EchidnaConfig {
    address internal constant ADDRESS_DEPLOYER =
        0x5409ED021D9299bf6814279A6A1411A7e866A631;
    address internal constant ADDRESS_ATTACKER0 =
        0x6Ecbe1DB9EF729CBe972C83Fb886247691Fb6beb;
    address internal constant ADDRESS_ATTACKER1 =
        0xE36Ea790bc9d7AB70C55260C66D52b1eca985f84;
    address internal constant ADDRESS_VICTIM =
        0xE834EC434DABA538cd1b9Fe1582052B880BD7e63;

    function getAccount(uint256 id) internal pure returns (address) {
        if (id == 0) return ADDRESS_DEPLOYER;
        if (id == 1) return ADDRESS_ATTACKER0;
        if (id == 2) return ADDRESS_ATTACKER1;
        if (id == 3) return ADDRESS_VICTIM;

        require(false, "Unknown account ID");
    }

    function getAccountFromUint8(uint8 rawId) internal pure returns (address) {
        uint256 id = uint256(rawId) / 64;
        return getAccount(id);
    }
}
