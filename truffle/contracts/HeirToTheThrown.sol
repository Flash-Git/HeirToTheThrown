/* 
function transferCrown(address _newMonarch) public onlyMonarch {
    _transferCrown(_newMonarch);
}

//why not put this in transferCrown?
function _transferCrown(address _newMonarch) internal {
    require(_newMonarch != address(0));
    emit CrownTransferred(activeMonarchAddr, _newMonarch);
    activeMonarchAddr = _newMonarch;
}
*/
pragma solidity ^0.4.24;

import "./Ownable.sol";

contract HeirToTheThrown is Ownable {

	//Points to latest contract
	address public latestContract;

	//is using a mapping better than using an array here?
	dynasty[] public dynasties;

	//cost to become new monarch
	uint public crownCost;

	//How much higher than the last each price has to be (as a percentage)
	uint public coefCostPerc = 2;
	//Cost to abdicate (as a percentage)
	uint public abdicationCostPerc = 5;

	//Taxes pay towards
	uint public taxesHeld;

	struct monarch {
		address addr;
		string name;
		uint costOfCrown;
		bool abdicated;
	}

	struct dynasty {
		string name;
		monarch[] monarchs;
		uint totalMonarchs;//number of monarchs in this dynasty
	}

	modifier onlyMonarch() {
		require(msg.sender == getActiveMonarch().addr, "Not the monarch");
		_;
	}

	//Events
	event DynastyStarted(address indexed DynastyStarter);
	event CrownRenounced(address indexed previousMonarch);
	event CrownTaken(address indexed previousMonarch, address indexed newMonarch, uint amount);
	event TaxesPayed(address indexed from, address indexed currentMonarch, uint amount);

	constructor(uint _startingCost) public payable {
		latestContract = address(this);
		contractOwner = msg.sender;
		crownCost = _startingCost;
		startDynasty("Flash", "First");
	}

	function() public payable {
		//
	}

	function takeCrown(string _heirName) public payable {//TODO Check for exploits
		require(msg.value + taxesHeld >= crownCost, "Cannot afford the Crown");
		uint value = msg.value + taxesHeld;
		taxesHeld = 0;

		monarch memory newMonarch = monarch(msg.sender, _heirName, value, false);

		if (dynasties.length == 1 && dynasties[0].monarchs.length < 1) {
			contractOwner.transfer(value);
			emit CrownTaken(contractOwner, newMonarch.addr, value);
		} else {
			getActiveMonarch().addr.transfer(value);
			emit CrownTaken(getActiveMonarch().addr, newMonarch.addr, value);
		}

		dynasties[dynasties.length - 1].monarchs.push(newMonarch);

		dynasties[dynasties.length - 1].totalMonarchs++;

		crownCost = value + value * coefCostPerc / 100;
	}

	function takeCrown1(uint _crownCost) public payable {//TEMP
		crownCost = _crownCost;
	}

	function startDynasty(string _heirName, string _dynastyName) public payable {
		if (dynasties.length != 0) {
			require(dynasties[dynasties.length - 1].monarchs[dynasties[dynasties.length - 1].monarchs.length - 1].abdicated, "Last Dynasty is still going strong");
		}
		dynasties.length++;
		dynasties[dynasties.length - 1].name = _dynastyName;
		takeCrown(_heirName);
		emit DynastyStarted(msg.sender);
	}

	function abdication() private pure {//TODO

	}

	function abdicate() public payable onlyMonarch {
		require(msg.value >= getActiveMonarch().costOfCrown * abdicationCostPerc * 100);
		contractOwner.transfer(getActiveMonarch().costOfCrown * abdicationCostPerc * 100);
	}

	function getActiveMonarch() private view returns (monarch) {
		return dynasties[dynasties.length - 1].monarchs[dynasties[dynasties.length - 1].monarchs.length - 1];
	}

	function getActiveMonarchAddr() external view returns (address) {
		return dynasties[dynasties.length - 1].monarchs[dynasties[dynasties.length - 1].monarchs.length - 1].addr;
	}

	function payTaxes() public payable {
		taxesHeld += msg.value / 2;
		emit TaxesPayed(msg.sender, getActiveMonarch().addr, msg.value);
	}

	//Getters for monarch with indices
	function getMonarchAddr(uint _dynastyIndex, uint _monarchIndex) external view returns (address){
		require(_dynastyIndex < dynasties.length && _monarchIndex < dynasties[_dynastyIndex].monarchs.length, "Invalid monarch");
		return dynasties[_dynastyIndex].monarchs[_monarchIndex].addr;
	}

	function getMonarchName(uint _dynastyIndex, uint _monarchIndex) external view returns (string){
		require(_dynastyIndex < dynasties.length && _monarchIndex < dynasties[_dynastyIndex].monarchs.length, "Invalid monarch");
		return dynasties[_dynastyIndex].monarchs[_monarchIndex].name;
	}

	function getMonarchCrownCost(uint _dynastyIndex, uint _monarchIndex) external view returns (uint){
		require(_dynastyIndex < dynasties.length && _monarchIndex < dynasties[_dynastyIndex].monarchs.length, "Invalid monarch");
		return dynasties[_dynastyIndex].monarchs[_monarchIndex].costOfCrown;
	}

	function hasMonarchAbdicated(uint _dynastyIndex, uint _monarchIndex) external view returns (bool){
		require(_dynastyIndex < dynasties.length && _monarchIndex < dynasties[_dynastyIndex].monarchs.length, "Invalid monarch");
		return dynasties[_dynastyIndex].monarchs[_monarchIndex].abdicated;
	}

	function getActiveDynasty() private view returns (dynasty) {
		return dynasties[dynasties.length - 1];
	}

	function getTotalDynasties() external view returns (uint) {
		return dynasties.length;
	}

	function changeAddr(address _newAddress) public onlyMonarch {
		dynasties[dynasties.length - 1].monarchs[dynasties[dynasties.length - 1].monarchs.length - 1].addr = _newAddress;
		// getActiveMonarch().addr does not work
	}

	//If this code gets updated, point to it here
	function setLatestContract(address _latestContract) public onlyContractOwner {
		latestContract = _latestContract;
	}

	function contractWithdrawal() public onlyContractOwner {
		msg.sender.transfer(address(this).balance - taxesHeld);
		//Withdraws anything that isn't taxes
	}

}