pragma solidity 0.8.0; 
contract InvestmentContract { 
    address public owner; 
    uint public investmentAmount; 
    constructor() { 
        owner = msg.sender; 
    } 
    function invest() public payable { 
        require(msg.value , "Investment must be greater than zero"); 
        investmentAmount += msg.value; 
    } 
    function withdraw(uint amount) public { 
        require(msg.sender == owner, "Only owner can withdraw"); 
        payable(owner).transfer(amount); 
        investmentAmount -= amount; 
    } 
} 
