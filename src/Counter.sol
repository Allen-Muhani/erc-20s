// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
// https://www.youtube.com/watch?v=sas02qSFZ74&t=21972s

contract Counter {
    uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
