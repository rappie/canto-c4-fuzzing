// SPDX-License-Identifier: MIT

import "./EchidnaSetup.sol";
import "./EchidnaHelper.sol";
import "./EchidnaDebug.sol";
import "./Debugger.sol";
import "./Tools.sol";

contract EchidnaTest is EchidnaSetup, EchidnaHelper, EchidnaDebug {
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
