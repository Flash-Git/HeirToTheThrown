const HeirToTheThrown = artifacts.require("HeirToTheThrown");

contract("HeirToTheThrown Tests",
	async(accounts) => {
		let heirToTheThrown;

		/*
		beforeEach(
			async() => {
				heirToTheThrown = await HeirToTheThrown.new(1000000000000000000, {from: accounts[0], value: 1000000000000000000});
			}
		);

		afterEach(
			async() => {
				//await heirToTheThrown.kill({from: accounts[0]});
			}
		);
		*/

		it(
			"should set initial values", async() => {
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
			"should set new heir", async() => {
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

		it(
			"should abdicate and create new dynasty", async() => {
				let instance = await HeirToTheThrown.deployed();

				//await instance.abdicate({from: accounts[0], value: 100000000000000000})

				let expectedCrownCost = 1040400000000000000;
				let crownCost = await instance.crownCost();
				assert.equal(crownCost, expectedCrownCost);
			}
		);
	}
);