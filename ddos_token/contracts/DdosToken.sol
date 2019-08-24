pragma solidity 0.4.24;

import "openzeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/MintableToken.sol";
import "openzeppelin-solidity/contracts/token/ERC20/BurnableToken.sol";

contract DdosToken is ERC20, DetailedERC20, MintableToken, BurnableToken  {
    constructor() DetailedERC20("DDoS Token", "DDOS", 18) public {
    }
}