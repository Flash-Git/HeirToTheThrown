pragma solidity ^0.4.24;

contract Keccak {

	function computeNamehash(string _name) public pure returns (bytes32) {
		bytes32 namehash = 0x0000000000000000000000000000000000000000000000000000000000000000;
		namehash = keccak256(
			abi.encodePacked(namehash, keccak256(abi.encodePacked("eth")))
		);
		namehash = keccak256(
			abi.encodePacked(namehash, keccak256(abi.encodePacked(_name)))
		);
		return namehash;
	}

}