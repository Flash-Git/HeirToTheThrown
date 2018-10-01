const HeirToTheThrown = artifacts.require("./HeirToTheThrown.sol");

module.exports = function(deployer) {
	deployer.deploy(HeirToTheThrown, 5, { value: 5 });
};