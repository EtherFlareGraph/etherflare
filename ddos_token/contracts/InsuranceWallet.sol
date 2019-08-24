pragma solidity 0.4.24;

import "./SafeMath.sol";

contract InsuranceWallet {
    using SafeMath for uint256;
    
    uint public minimalAmount;
    
    address public owner;
    mapping(address => bool) ddosContracts;
    
    constructor(uint _minimalAmount) public {
        owner = msg.sender;
        minimalAmount = _minimalAmount;
    }
    
    function addContract(address _address) public onlyOwner {
        ddosContracts[_address] = true;
    }
    
    function withdraw(uint _amount) public onlyOwner {
        require(address(this).balance.sub(_amount) >= minimalAmount);
        require(address(this).balance.sub(_amount) >=0);
        msg.sender.transfer(_amount);
    }
    
    function payoff(address _to, uint _amount) public onlyDdosContract {
        _to.transfer(_amount);
    }
    
      modifier onlyOwner() {
        require(msg.sender == owner);
        _;
      }
      
      modifier onlyDdosContract() {
        require(ddosContracts[msg.sender]);
        _;
      }
    
}