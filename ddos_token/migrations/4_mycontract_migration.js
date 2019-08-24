var MyContract = artifacts.require("MyContract");
var LinkToken = artifacts.require("LinkToken");
var Oracle = artifacts.require("Oracle");

module.exports = (deployer, network, accounts) => {
  deployer.deploy(MyContract, LinkToken.address, Oracle.address, {from: accounts[0]});
};