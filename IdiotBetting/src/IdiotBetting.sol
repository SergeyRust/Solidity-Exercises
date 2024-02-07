// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;
import "forge-std/console.sol";

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

    function bet() public payable {
        if (msg.value > maxBid.highestBid) {
            uint256 time = block.timestamp + 1 hours;
            maxBid = MaxBid(msg.sender, msg.value, time);
            console.log("bet() is starting");
            console.log("current idiot : %d", maxBid.idiot);
            console.log("maxBid : %d", maxBid.highestBid);
            console.log("endTime : %d", time);
            console.log("bet() is finishing \n");
        }
    }

    function claimPrize() public {
//        if (msg.sender == maxBid.idiot && maxBid.endTime > block.timestamp) {
        console.log("claimPrize() is starting");
        console.log("current idiot : %d", msg.sender);
        console.log("maxBidIdiot : %d", maxBid.idiot);
        console.log("maxBid : %d", maxBid.highestBid);
        console.log("endTime : %d", maxBid.endTime);
        require(msg.sender == maxBid.idiot && maxBid.endTime > block.timestamp);
        address payable to = payable(msg.sender);
        uint amount = address(this).balance;
        to.transfer(amount);
        console.log("claimPrize() is finishing \n");
//        } else {
//            revert();
//        }
    }
}
