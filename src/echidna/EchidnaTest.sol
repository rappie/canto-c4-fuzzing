// SPDX-License-Identifier: MIT

import "./EchidnaSetup.sol";
import "./EchidnaHelper.sol";
import "./EchidnaDebug.sol";
import "./Debugger.sol";
import "./Tools.sol";

contract EchidnaTest is EchidnaSetup, EchidnaHelper, EchidnaDebug {
    function testBuyShouldNotRevert(uint8 fromAccId, uint8 _amount) public {
        address from = getAccountFromUint8(fromAccId);
        uint256 amount = uint256(_amount);

        require(note.balanceOf(from) >= amount * tray.trayPrice());
        require(
            note.allowance(from, address(tray)) >= amount * tray.trayPrice()
        );
        require(amount > 0);
        require(amount < 73); // prevent out of gas error

        hevm.prank(from);
        try tray.buy(amount) {
            Debugger.log("buy success");
        } catch {
            Debugger.log("buy failed");
            assert(false);
        }
    }

    function testTokenURIShouldNotRevert(uint256 tokenId) public {
        uint256 count = tray.nextTokenId() - 1;
        require(count > 0);

        tokenId = (tokenId % count) + 1;

        try tray.tokenURI(tokenId) returns (string memory uri) {
            Debugger.log("did not revert");
        } catch {
            Debugger.log("reverted");
            assert(false);
        }
    }
}
