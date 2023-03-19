// SPDX-License-Identifier: MIT

import "./EchidnaHelper.sol";
import "./Debugger.sol";

contract EchidnaDebug is EchidnaHelper {
    // bool debug = true;

    bool debug = false;

    function debugTrayCount() public {
        uint256 count = tray.nextTokenId() - 1;
        Debugger.log("tray count", count);
        assert(count <= 5);
    }

    // function debugTray() public {
    //     require(debug, "Debugging is disabled");

    //     Debugger.log("tray contract owner", tray.owner());

    //     hevm.prank(ADDRESS_DEPLOYER);
    //     try tray.buy(1) {
    //         Debugger.log("buy(1) succeeded");
    //     } catch {
    //         Debugger.log("buy(1) failed");
    //     }

    //     Debugger.log("owner", tray.ownerOf(1));

    //     assert(false);
    // }
}
