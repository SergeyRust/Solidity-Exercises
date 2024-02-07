// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract BasicBank {
    uint256 private balanceReceived;
    /// @notice deposit ether into the contract
    /// @dev it should work properly when called multiple times
    function addEther() external payable {
        //value += msg.value;
        //address(this).transfer(msg.value);
        balanceReceived += msg.value;
    }

    /// @notice used to withdraw ether from the contract (No restriction on withdrawals)
    function removeEther(uint256 amount) external payable {
        //value -= amount;
        address payable to = payable(msg.sender);
        to.transfer(amount);
    }
}
