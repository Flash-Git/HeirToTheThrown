pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/HeirToTheThrown.sol";

contract TestHeirToTheThrown {

	function testBasics() public {
		HeirToTheThrown inst = HeirToTheThrown(DeployedAddresses.HeirToTheThrown());
		Assert.equal(inst.coefCostPerc(), 2, "should be two");
	}

}