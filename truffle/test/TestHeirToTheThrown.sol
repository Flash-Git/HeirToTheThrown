pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/HeirToTheThrown.sol";

contract TestHeirToTheThrown {

	uint initialCrownCost = 1 ether;
	uint crownIncrease = 102;

	function testConstructor() public {
		HeirToTheThrown inst = HeirToTheThrown(DeployedAddresses.HeirToTheThrown());

		address expectedLatestContract = DeployedAddresses.HeirToTheThrown();
		Assert.equal(inst.latestContract(), expectedLatestContract, "latest contract address");

		address expectedContractOwner = tx.origin;
		Assert.equal(inst.contractOwner(), expectedContractOwner, "contract owner");

		uint expectedCrownCost = initialCrownCost * crownIncrease / 100;
		Assert.equal(inst.crownCost(), expectedCrownCost, "crown cost");
	}

	function testInitialState() public {
		HeirToTheThrown inst = HeirToTheThrown(DeployedAddresses.HeirToTheThrown());

		//string storage expectedDynastyName = "First";
		//Assert.equal(name, expectedDynastyName, "dynasty name");//Not currently possible

		//uint expectedDynastyNum = 1;
		//Assert.equal(inst.dynasties[0].monarchs.length(), expectedDynastyNum, "dynasty number");//Unsure how to access struct arrays

		uint expectedTaxesHeld = 0;
		Assert.equal(inst.taxesHeld(), expectedTaxesHeld, "taxes held");
	}

	function testNewMonarch() public {
		HeirToTheThrown inst = HeirToTheThrown(DeployedAddresses.HeirToTheThrown());

		uint expectedCrownCost = initialCrownCost * crownIncrease / 100;
		Assert.equal(inst.crownCost(), expectedCrownCost, "crown cost");

		inst.takeCrown.value(expectedCrownCost)("123");
		//Error: VM Exception while processing transaction: revert
		Assert.equal(inst.crownCost(), 0, "crown cost");
	}

	function testCallerBalance() public {
		uint expectedBalance = 0;
		Assert.equal(tx.origin.balance, expectedBalance, "balance");
		//Should fail, just checking balance
	}

}