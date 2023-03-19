// SPDX-License-Identifier: MIT

import "./EchidnaHelper.sol";
import "./Debugger.sol";

contract EchidnaDebug is EchidnaHelper {
    // bool debug = true;

    bool debug = false;

    function debugTrayAddress() public {
        require(debug);
        Debugger.log("tray address", address(tray));
        assert(false);
    }

}
