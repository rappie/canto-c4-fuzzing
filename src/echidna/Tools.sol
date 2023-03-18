// SPDX-License-Identifier: MIT

library Tools {
    function getDeviation(
        uint256 value1,
        uint256 value2,
        uint256 base
    ) internal pure returns (uint256) {
        uint256 difference = diff(value1, value2);
        uint256 deviation = diff(difference, base);
        return deviation;
    }

    function diff(uint256 value1, uint256 value2)
        internal
        pure
        returns (uint256)
    {
        uint256 difference = value1 > value2
            ? value1 - value2
            : value2 - value1;
        return difference;
    }
}
