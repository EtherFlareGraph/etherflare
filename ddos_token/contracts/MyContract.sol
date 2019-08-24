pragma solidity 0.4.24;

import "chainlink/contracts/ChainlinkClient.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

import "openzeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/MintableToken.sol";
import "openzeppelin-solidity/contracts/token/ERC20/BurnableToken.sol";

contract DdosToken is ERC20, DetailedERC20, MintableToken, BurnableToken  {

    modifier hasMintBurnPermission() {
        require(msg.sender == owner);
        _;
    }
    
    constructor() DetailedERC20("DDoS Token", "DDOS", 18) public {
    }

    function burn(address _who, uint256 _value) public hasMintBurnPermission {
        require(_value <= balances[_who]);

        balances[_who] = balances[_who].sub(_value);
        totalSupply_ = totalSupply_.sub(_value);
        emit Burn(_who, _value);
        emit Transfer(_who, address(0), _value);
    }
    
    function mint(address _to, uint256 _amount) public hasMintBurnPermission returns (bool)
    {
        totalSupply_ = totalSupply_.add(_amount);
        balances[_to] = balances[_to].add(_amount);
        emit Mint(_to, _amount);
        emit Transfer(address(0), _to, _amount);
        return true;
    }
}

/**
 * @title MyContract is an example contract which requests data from
 * the Chainlink network
 * @dev This contract is designed to work on multiple networks, including
 * local test networks
 */
contract MyContract is ChainlinkClient, Ownable {
    // solium-disable-next-line zeppelin/no-arithmetic-operations
    uint256 constant private DDOS = 1;
    uint256 constant private ORACLE_PAYMENT = 1 * LINK;
    uint256 public checkID;
    uint256 public downtime;
    uint256 public lastCheck;
    uint256 public maxDowntime;
    address public tokenAddress;
  
    constructor(
            address _link, address _oracle, uint _maxDowntime, address _tokenAddress
        ) public {
        maxDowntime = _maxDowntime;
        tokenAddress = _tokenAddress;
        setChainlinkToken(_link);
        setChainlinkOracle(_oracle);
    }
    
    function buyToken() public payable {
        DdosToken(tokenAddress).mint(msg.sender, msg.value*DDOS);
    }
    
    function sellToken(uint _amount) public {
        require(block.number - lastCheck < 100, "Downtime asked long time ago. Ask it again");
        uint ratio = downtime / maxDowntime; // 10 ** 18
        uint val = _amount*DDOS*ratio / 10 ** 18;
        DdosToken(tokenAddress).burn(msg.sender, _amount);
        msg.sender.transfer(val);
    }
    
    function price(uint _amount) public view returns (uint) {
        uint ratio = downtime / maxDowntime; // 10 ** 18
        uint val = _amount*DDOS*ratio / 10 ** 18;
        return val;
    }
    
    function getChainlinkToken() public view returns (address) {
        return chainlinkTokenAddress();
    }
    
    function getOracle() public view returns (address) {
        return chainlinkOracleAddress();
    }
    
    function getCheckId(
        address _oracle,
        bytes32 _jobId
    )
    public
    onlyOwner
    returns (bytes32 requestId)
    {
        Chainlink.Request memory req = buildChainlinkRequest(_jobId, this, this.fulfillCheckId.selector);
        req.add("url", "https://api.pingdom.com/api/2.1/checks");
        string[] memory path = new string[](3);
        path[0] = "checks";
        path[1] = "0";
        path[2] = "id";
        req.addStringArray("path", path);
        requestId = sendChainlinkRequestTo(_oracle, req, ORACLE_PAYMENT);
    }
    
    function getDowntime(
        address _oracle,
        bytes32 _jobId
    )
    public
    onlyOwner
    returns (bytes32 requestId)
    {
        Chainlink.Request memory req = buildChainlinkRequest(_jobId, this, this.fulfillDowntime.selector);
        req.add("url", "https://api.pingdom.com/api/2.1/summary.average/");
        req.add("extPath", uint2str(checkID));
        req.add("queryParams", "includeuptime=true");
        string[] memory path = new string[](3);
        path[0] = "summary";
        path[1] = "status";
        path[2] = "totaldown";
        req.addStringArray("path", path);
        requestId = sendChainlinkRequestTo(_oracle, req, ORACLE_PAYMENT);
    }
    
    function fulfillCheckId(bytes32 _requestId, uint256 _data)
    public
    recordChainlinkFulfillment(_requestId)
    {
        checkID = _data;
    }
    
    function fulfillDowntime(bytes32 _requestId, uint256 _data)
    public
    recordChainlinkFulfillment(_requestId)
    {
        downtime = 10**18 * _data * 100 / 2592000;
        lastCheck = block.number; 
    }
    
    function updateCheckId(uint256 _data) public onlyOwner 
    {
      checkID = _data;
    }
    
    function updateDowntime(uint256  _data) public onlyOwner
    {
        downtime = 10**18 * _data * 100 / 2592000;
        lastCheck = block.number; 
    }
    
    /**
    * @notice Allows the owner to withdraw any LINK balance on the contract
    */
    function withdrawLink() public onlyOwner {
    LinkTokenInterface link = LinkTokenInterface(chainlinkTokenAddress());
    require(link.transfer(msg.sender, link.balanceOf(address(this))), "Unable to transfer");
    }
  
    function cancelRequest(
        bytes32 _requestId,
        uint256 _payment,
        bytes4 _callbackFunctionId,
        uint256 _expiration
    )
    public
      onlyOwner
    {
        cancelChainlinkRequest(_requestId, _payment, _callbackFunctionId, _expiration);
    }
    
    function uint2str(uint i) internal pure returns (string){
        if (i == 0) return "0";
        uint j = i;
        uint length;
        while (j != 0){
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint k = length - 1;
        while (i != 0){
            bstr[k--] = byte(48 + i % 10);
            i /= 10;
        }
        return string(bstr);
    }
}