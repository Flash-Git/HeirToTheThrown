pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/HeirToTheThrown.sol";

contract TestHeirToTheThrown {

	function testConstructor() public {
		HeirToTheThrown inst = HeirToTheThrown(DeployedAddresses.HeirToTheThrown());

		uint expectedCrownCost = 5;
		Assert.equal(inst.crownCost(), expectedCrownCost, "crown cost");

		address expectedLatestContract = DeployedAddresses.HeirToTheThrown();
		Assert.equal(inst.latestContract(), expectedLatestContract, "latest contract address");
	}

	//function testInitialState() public {
		//HeirToTheThrown inst = HeirToTheThrown(DeployedAddresses.HeirToTheThrown());

		//string storage expectedDynastyName = "First";
		//string storage name = "First";
		//Assert.equal(name, expectedDynastyName, "dynasty name");
	//}

}