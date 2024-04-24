//SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

contract Coin {
    address public minter;
    mapping(address => uint256) balances;

    event Sent(address from, address to, uint256 amount);

    //constructor to be deployed at the start;
    constructor() {
        minter = msg.sender;
    }

    //mint new coins and send to an address;
    //only the owner should consent to the coins;
    function mint(address receiver, uint256 amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    //insufficient balance error;
    error NotEnoughBalance(uint256 requested, uint256 available);

    //send any amount to an existing address;
    function sendCoin(address receiver, uint256 amount) public {
        //revert statement if amount is greater than the balance;
        if (amount > balances[msg.sender]) {
            revert NotEnoughBalance({
                requested: amount,
                available: balances[msg.sender]
            });
        }

        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}
