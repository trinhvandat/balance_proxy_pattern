// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract BalanceImpl {
    bool private initialized;
    uint private balance;

    modifier initializer() {
        require(!initialized, "This contract is initialized");
        _;
    }

    function initial() public initializer {
        initialized = true;
    }

    function add(uint _amount) public {
        balance += _amount;
    }

    function getBalance() public view returns(uint) {
        return balance;
    }
}