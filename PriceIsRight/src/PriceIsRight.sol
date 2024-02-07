// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract PriceIsRight {
    /// @dev make this function revert unless exactly 1 ether is sent as value in the function call
    function buy() public payable {
        if (msg.value != 1 ether) {
            revert("1 ether isn't sent as value in the function call");
        }
    }
}
