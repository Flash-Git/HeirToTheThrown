const HeirToTheThrown = artifacts.require("HeirToTheThrown");

contract("HeirToTheThrown test",
	async (accounts) => {
		it("should set the first monarch", async () => {
			let instance = await HeirToTheThrown.deployed();
			let name = await instance.dynasties.name();
			assert.equal(name, "First");
			}
		);
	}
);