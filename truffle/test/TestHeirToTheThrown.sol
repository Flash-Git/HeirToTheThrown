pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/HeirToTheThrown.sol";

contract TestHeirToTheThrown {

	function testConstructor() public {
		HeirToTheThrown inst = HeirToTheThrown(DeployedAddresses.HeirToTheThrown());

		address expectedLatestContract = DeployedAddresses.HeirToTheThrown();
		Assert.equal(inst.latestContract(), expectedLatestContract, "latest contract address");

		address expectedContractOwner = tx.origin;
		//0xbdBF43c997561DCaDA6ca0C28dE0803dF2e3b029
		Assert.equal(inst.contractOwner(), expectedContractOwner, "contract owner");

		uint expectedCrownCost = 1020000000000000000;
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

		inst.takeCrown2.value(1020000000000000000)("name");
	}

}