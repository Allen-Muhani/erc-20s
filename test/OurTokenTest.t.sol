// SPDX-Licence-Identifeir: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {OurToken} from "../src/OurToken.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";

contract OurTokenTests is Test {
    OurToken private token;

    DeployOurToken private deployer;

    address bob = makeAddr("bob");

    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 1000 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        token = deployer.run();

        vm.prank(msg.sender);
        token.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() view public {
        assertEq(token.balanceOf(bob), STARTING_BALANCE);
    }

    function testAliceBalance() view public {
        assertEq(token.balanceOf(alice), 0);
    }

    function testAllowances() public {
        assertEq(token.allowance(bob, alice), 0);
        assertEq(token.allowance(alice, bob), 0);

        vm.prank(bob);
        token.approve(alice, 50 ether);

        assertEq(token.allowance(bob, alice), 50 ether);

        vm.prank(alice);
        token.transferFrom(bob, alice, 20 ether);

        assertEq(token.allowance(bob, alice), 30 ether);
        assertEq(token.balanceOf(bob), 980 ether);
        assertEq(token.balanceOf(alice), 20 ether);
    }

    function testTransfer() public {
        vm.prank(bob);
        token.transfer(alice, 100 ether);

        assertEq(token.balanceOf(bob), 900 ether);
        assertEq(token.balanceOf(alice), 100 ether);
    }

    function testInitialSupply() view public {
        assertEq(token.totalSupply(), 1000 ether);
    }

    function testName() view public {
        assertEq(token.name(), "OurToken");
    }

    function testSymbol() view public {
        assertEq(token.symbol(), "OTK");
    }

    function testDecimals() view public {
        assertEq(token.decimals(), 18);
    }
}
