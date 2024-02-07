// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;
import "forge-std/console.sol";

contract FilterOddNumbers {
    /*
        This exercise assumes you understand how to manipulate Array.
        1. Function `filterOdd` takes an array of uint256 as argument. 
        2. Filter and return an array with the odd numbers removed.
        Note: this is tricky because you cannot allocate a dynamic array in memory, 
              you need to count the even numbers then declare an array of that size.
    */

    function filterOdd(uint256[] memory _arr)
        public
        view
        returns (uint256[] memory)
    {
        uint256 count_odd = 0;
        for (uint256 i = 0; i < _arr.length; i++) {
            if (_arr[i] % 2 != 0) {
                count_odd++;
            }
        }
        console.log("count_odd: %d", count_odd);

        uint256 evenLength = _arr.length - count_odd;
        console.log("evenLength: %d", evenLength);

        uint256[] memory even_arr = new uint256[](evenLength);
        uint256 evenCount = 0;
        for (uint256 i = 0; i < _arr.length; i++) {
            if (_arr[i] % 2 == 0) {
                even_arr[evenCount] = _arr[i];
                console.log("evenCount : %d , even_arr[evenCount]: %d", evenCount, even_arr[evenCount]);
                evenCount++;
            }
        }

        return even_arr;
    }
}
