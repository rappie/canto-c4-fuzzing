// SPDX-License-Identifier: MIT

import "./IHevm.sol";
import "./EchidnaConfig.sol";

import {MockToken} from "../test/mock/MockToken.sol";
import {MockNamespace} from "../test/mock/MockNamespace.sol";
import {MockTray} from "../test/mock/MockTray.sol";
import {Tray} from "../Tray.sol";
import {Namespace} from "../Namespace.sol";
import {Base64} from "solady/utils/Base64.sol";
import {LibString} from "solmate/utils/LibString.sol";

contract EchidnaSetup is EchidnaConfig {
    IHevm hevm = IHevm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    bytes32 internal constant INIT_HASH =
        0xc38721b5250eca0e6e24e742a913819babbc8948f0098b931b3f53ea7b3d8967;

    Namespace namespace;
    MockTray tray;
    MockToken note;

    uint256 price;

    constructor() public {
        note = new MockToken();
        price = 100e18;

        tray = new MockTray(
            INIT_HASH,
            price,
            ADDRESS_DEPLOYER, // revenue
            address(note),
            address(0) // namespace
        );
        tray.transferOwnership(ADDRESS_DEPLOYER); // hevm.prank doesnt work with constructors?

        namespace = new Namespace(
            address(tray),
            address(note),
            ADDRESS_DEPLOYER // revenue
        );
        namespace.transferOwnership(ADDRESS_DEPLOYER); // hevm.prank doesnt work with constructors?

        tray.setNamespace(address(namespace));

        hevm.prank(ADDRESS_DEPLOYER);
        tray.endPrelaunchPhase();

        note.mint(ADDRESS_DEPLOYER, 10000e18);
        hevm.prank(ADDRESS_DEPLOYER);
        note.approve(address(tray), type(uint256).max);

        note.mint(ADDRESS_ATTACKER0, 10000e18);
        hevm.prank(ADDRESS_ATTACKER0);
        note.approve(address(tray), type(uint256).max);
    }
}
