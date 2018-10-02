pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Keccak.sol";

contract TestKeccak {

	function testHash() public {
		Keccak inst = Keccak(DeployedAddresses.Keccak());

		bytes32 expectedOutput = 0x97cfedec9988fa1695d3e0ecdb83937c4d898baa3558ab3d24e1140e06a4d941;
		Assert.equal(inst.computeNamehash("jaquinn"), expectedOutput, "Failed to get name hash");
	}

}