// SPDX-License-Identifier: MIT

import "./EchidnaSetup.sol";
import "./Debugger.sol";

contract EchidnaHelper is EchidnaSetup {
    function buy(uint8 fromAccId, uint256 amount) public {
        address from = getAccountFromUint8(fromAccId);

        hevm.prank(from);
        tray.buy(amount);
    }

    function mint(uint8 toAccId, uint256 amount) public {
        address to = getAccountFromUint8(toAccId);
        note.mint(to, amount);
    }

    function approve(uint8 fromAccId, uint256 amount) public {
        address from = getAccountFromUint8(fromAccId);
        hevm.prank(from);
        note.approve(address(tray), amount);
    }

    function mintAndApprove(uint8 fromAccId, uint256 amount) public {
        mint(fromAccId, amount);
        approve(fromAccId, amount);
    }
}
