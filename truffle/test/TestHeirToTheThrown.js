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
				assert.equal(crownCost, expectedCrownCost);

				let expectedTaxesHeld = 0;
				let taxesHeld = await instance.taxesHeld();
				assert.equal(taxesHeld, expectedTaxesHeld);

				let expectedTotalDynasties = 1;
				let totalDynasties = await instance.getTotalDynasties();
				assert.equal(totalDynasties, expectedTotalDynasties);

				let expectedNumberOfMonarchs = 1
				let numberOfMonarchs = await instance.getDynastyLength(0);
				assert.equal(numberOfMonarchs, expectedNumberOfMonarchs);
			}
		);

		it(
			"should set new heir", async () => {
				let instance = await HeirToTheThrown.deployed();

				await instance.takeCrown("2", {from: accounts[0], value: 1020000000000000000})

				let expectedCrownCost = 1040400000000000000;
				let crownCost = await instance.crownCost();
				assert.equal(crownCost, expectedCrownCost);

				let expectedNumberOfMonarchs = 2
				let numberOfMonarchs = await instance.getDynastyLength(0);
				assert.equal(numberOfMonarchs, expectedNumberOfMonarchs);
			}
		);
	}
);