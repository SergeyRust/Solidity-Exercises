// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;
import "forge-std/console.sol";

contract IsSorted {
    /**
     * The goal of this exercise is to return true if the members of "arr" is sorted (in ascending order) or false if its not.
     */
    function isSorted(uint256[] calldata arr) public view returns (bool) {

        for (uint256 i = 0; i < arr.length - 1; i++) {

            console.log("arr[i]: %d, arr[i+1]: %d", arr[i], arr[i+1]);

            if (arr[i] > arr[i+1]) {
                console.log("returning false \n");
                return false;
            }
        }
        console.log("returning true \n");
        return true;
    }
}
