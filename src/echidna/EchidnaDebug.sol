// SPDX-License-Identifier: MIT

import "./EchidnaHelper.sol";
import "./Debugger.sol";

contract EchidnaDebug is EchidnaHelper {
    // bool debug = true;

    bool debug = false;

    function debugNamespace() public {
        require(debug);

        address from = ADDRESS_DEPLOYER;

        uint256 trayId = tray.nextTokenId();
        hevm.prank(from);
        tray.buy(1);

        Namespace.CharacterData[] memory list = new Namespace.CharacterData[](
            1
        );
        list[0] = Namespace.CharacterData(trayId, 0, 0);

        hevm.prank(from);
        try namespace.fuse(list) {
            Debugger.log("success");
        } catch {
            Debugger.log("fail");
        }

        assert(false);
    }

}
