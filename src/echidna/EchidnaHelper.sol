// SPDX-License-Identifier: MIT

import "./EchidnaSetup.sol";

contract EchidnaHelper is EchidnaSetup {

    function buy(uint8 fromAccId, uint256 amount) public {
        address from = getAccountFromUint8(fromAccId);

        hevm.prank(from);
        tray.buy(amount);
    }
}
