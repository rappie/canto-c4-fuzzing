// SPDX-License-Identifier: MIT

import "./EchidnaSetup.sol";
import "./EchidnaHelper.sol";
import "./EchidnaDebug.sol";
import "./Debugger.sol";
import "./Tools.sol";

contract EchidnaTest is EchidnaSetup, EchidnaHelper, EchidnaDebug {
    function testFuseShouldNotRevert(uint8 fromAccId, uint256 trayId) public {
        address from = getAccountFromUint8(fromAccId);

        uint256 count = tray.nextTokenId() - 1;
        require(count > 0);
        trayId = (trayId % count) + 1;

        require(tray.ownerOf(trayId) == from);
        uint256 maxCost = (2**13) * 1e18;
        require(note.balanceOf(from) >= maxCost);
        require(note.allowance(from, address(namespace)) >= maxCost);

        Namespace.CharacterData[] memory list = new Namespace.CharacterData[](
            1
        );
        list[0] = Namespace.CharacterData(trayId, 0, 0);

        hevm.prank(from);
        try namespace.fuse(list) {
            Debugger.log("fuse success");
        } catch {
            Debugger.log("fuse fail");
            assert(false);
        }
    }

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

    function testTokenURIShouldNotRevert(uint256 trayId) public {
        uint256 count = tray.nextTokenId() - 1;
        require(count > 0);
        trayId = (trayId % count) + 1;

        try tray.tokenURI(trayId) returns (string memory uri) {
            Debugger.log("did not revert");
        } catch {
            Debugger.log("reverted");
            assert(false);
        }
    }
}
