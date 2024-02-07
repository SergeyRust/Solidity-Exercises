// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {

    address public seller;

    struct Order {
        uint value;
        uint256 time;
    }
    // buyer => Order
    mapping(address => Order) public orders;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */

    constructor() {
        seller = msg.sender;
    }

    // creates a buy order between msg.sender and seller
    /**
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but after which only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        Order memory order = Order(msg.value, block.timestamp);
        orders[msg.sender] = order;
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        Order memory order = orders[buyer];
        if (order.time + 3 days < block.timestamp) {
            address payable to = payable(seller);
            uint amount = order.value;
            order.value = 0;
            to.transfer(amount);
        } else {
            revert("3 days haven't passed");
        }
    }

    /**
     * allows buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        Order memory order = orders[msg.sender];
        if (order.time + 3 days > block.timestamp) {
            address payable to = payable(msg.sender);
            uint amount = order.value;
            order.value = 0;
            to.transfer(amount);
        } else {
            revert("order already has been processed");
        }
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        return orders[buyer].value;
    }
}
