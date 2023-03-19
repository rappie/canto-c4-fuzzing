// SPDX-License-Identifier: MIT

import "./EchidnaSetup.sol";
import "./EchidnaHelper.sol";
import "./EchidnaDebug.sol";
import "./Debugger.sol";
import "./Tools.sol";

contract EchidnaTest is EchidnaSetup, EchidnaHelper, EchidnaDebug {
    function testBuyShouldNotRevert(uint8 fromAccId, uint256 amount) public {
        address from = getAccountFromUint8(fromAccId);

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
