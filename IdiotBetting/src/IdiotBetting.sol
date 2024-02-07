// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IdiotBettingGame {
    /*
        This exercise assumes you know how block.timestamp works.
        - Whoever deposits the most ether into a contract wins all the ether if no-one 
          else deposits after an hour.
        1. `bet` function allows users to deposit ether into the contract. 
           If the deposit is higher than the previous highest deposit, the endTime is 
           updated by current time + 1 hour, the highest deposit and winner are updated.
        2. `claimPrize` function can only be called by the winner after the betting 
           period has ended. It transfers the entire balance of the contract to the winner.
    */

    struct MaxBid {
        address idiot;
        uint256 highestBid;
        uint256 endTime;
    }

    MaxBid private maxBid;

    //uint256 private endTime;

    function bet() public payable {
        if (msg.value > maxBid.highestBid) {
            uint256 time = block.timestamp;
            maxBid = MaxBid(msg.sender, msg.value, time + 1 hours);
            //endTime = time + 1 hours;
        }
    }

    function claimPrize() public {
//        if (msg.sender == maxBid.idiot && maxBid.endTime > block.timestamp) {
        require(msg.sender == maxBid.idiot && maxBid.endTime > block.timestamp);
            address payable to = payable(msg.sender);
            uint amount = address(this).balance;
            to.transfer(amount);
//        } else {
//            revert();
//        }
    }
}
