"use strict";
const MyContract = artifacts.require("MyContract.sol");
const InsuranceWallet = artifacts.require("InsuranceWallet.sol");
const DdosToken = artifacts.require("DdosToken.sol");
const w3utils = require('web3-utils');

contract("MyContract", (accounts) => {
  describe("# test calculations", () => {

    const token = await DdosToken.new();

    const insuranceWallet = await InsuranceWallet.new(
      w3utils.toWei(100, 'ether')
    );

    const instance = await MyContract.new(
      '0x20fe562d797a42dcb3399062ae9546cd06f63280',
      '0xE84a93d372CbAe15BE56a07C602F7a1bE6FB6Ea3',
      insuranceWallet.address,
      5
    );

  });
});
