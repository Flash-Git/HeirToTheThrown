const HeirToTheThrown = artifacts.require("HeirToTheThrown");

contract("HeirToTheThrown Tests",
	async (accounts) => {
		it(
			"should set initial values", async () => {
				let instance = await HeirToTheThrown.deployed();

				//let expectedLatestContract = instance"";
				//let latestContract = await instance.latestContract();
				//assert.equal(latestContract, expectedLatestContract);

				//let expectedContractOwner = instance"";
				//let contractOwner = await instance.contractOwner();
				//assert.equal(contractOwner, expectedContractOwner);

				let expectedBalance = 0;
				let balance = await instance.getEthBalance();
				assert.equal(balance, expectedBalance);

				let expectedCrownCost = 1020000000000000000;
				let crownCost = await instance.crownCost();
				assert.equal(crownCost.valueOf(), expectedCrownCost);

				let expectedTaxesHeld = 0;
				let taxesHeld = await instance.taxesHeld();
				assert.equal(taxesHeld.valueOf(), expectedTaxesHeld);
			}
		);
	}
);