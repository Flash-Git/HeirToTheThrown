const HeirToTheThrown = artifacts.require("./HeirToTheThrown.sol");
const Keccak = artifacts.require("./Keccak.sol");

module.exports = function(deployer) {
	deployer.deploy(HeirToTheThrown, 5, { value: 5 });
	deployer.deploy(Keccak);
};