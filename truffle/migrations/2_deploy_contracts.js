const HeirToTheThrown = artifacts.require("./HeirToTheThrown.sol");
const Keccak = artifacts.require("./Keccak.sol");

module.exports = function(deployer) {
	deployer.deploy(HeirToTheThrown, 1000000000000000000, { value: 1000000000000000000 });
	deployer.deploy(Keccak);
};