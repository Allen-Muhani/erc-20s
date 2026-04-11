// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ManualToken {

    /**
     * @dev Mapping from account addresses to current balance.
     */
    mapping(address => uint256) private s_balances;


    constructor() {}

    string public constant name = "ManualToken";

    string public constant symbol = "MTK";

    uint8 public constant decimals = 18;

    /**
     * The total token supply.
     */
    function totalSupply() public pure returns (uint256) {
        return 100 ether; // 100 tokens with 18 decimals or 100 * decimals()
    }

    function balanceOf(address _account) public view returns (uint256) {
        return s_balances[_account];
    }

    function transfer(address _to, uint256 _amount) public {
        require(_to != address(0), "Invalid address");
        require(_amount > 0, "Amount must be greater than zero");
        require(s_balances[msg.sender] >= _amount, "Insufficient balance");

        uint256 previouseBalances = balanceOf(msg.sender) + balanceOf(_to);

        s_balances[msg.sender] -= _amount;
        s_balances[_to] += _amount;

        require(balanceOf(msg.sender) + balanceOf(_to) == previouseBalances);
    }
}
