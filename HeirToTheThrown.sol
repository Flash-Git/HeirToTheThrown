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
pragma solidity 0.4.24;

contract HeirToTheThrown is Ownable {
    
    address public latestContract;

    monarch public activeMonarch;
	//is using a mapping better than using an array here?
	dynasty[] public dynasties;// each dynasty has an unsigned integer by which it is represented
	uint public totalDynasties;
	
	//cost to become new monarch
	uint public crownCost;

    //How much higher than the last each price has to be (as a percentage)
	uint public coefCostPerc = 2;
    //cost to abdicate (as a percentage)
	uint public abdicationCostPerc = 5;

	struct monarch {
		address addr;
		bytes32 name;
		uint costOfCrown;
		bool abdicated;
	}

	struct dynasty {
		bytes32 name;
		monarch[] monarchs;
		uint totalMonarchs;//number of monarchs in this dynasty
	}
	
	modifier onlyMonarch() {
        require(msg.sender == activeMonarch.addr, "Not the monarch");
        _;
    }

	//Events
	event DynastyStarted(address indexed newMonarch);
	event CrownRenounced(address indexed previousMonarch);
    event CrownPassedOn(address indexed previousMonarch, address indexed newMonarch);

	constructor() public {
	    latestContract = address(this);
	    contractOwner = msg.sender;
		startDynasty("Flash", "First");
	}

	function() public payable {
		//
	}

	function takeCrown(bytes32 _heirName) public payable {
		require(msg.value >= crownCost, "Cannot afford the Crown");
		crownCost = msg.value + msg.value * coefCostPerc / 100;
		activeMonarch.name = _heirName;
		activeMonarch.costOfCrown = msg.value;
		activeMonarch.addr.transfer(msg.value);
		activeMonarch.addr = msg.sender;
		//activeMonarch.abdicated = false;//does this default to false?
		dynasties[dynasties.length-1].monarchs.push(activeMonarch);//TODO testing
		dynasties[dynasties.length-1].totalMonarchs++;
	}
    
	function startDynasty(bytes32 _heirName, bytes32 _dynastyName) public payable {
	    if(dynasties.length != 0){
            require(dynasties[dynasties.length-1].monarchs[dynasties[dynasties.length-1].monarchs.length-1].abdicated, "Last Dynasty is still going strong");
	    }
        dynasty storage newDynasty;//Unfortunately needs to be storage TODO test consequences
	    dynasties.push(newDynasty);
	    //dynasties.push(dynasty(_dynastyName, new monarch[](0), 0));//Unsupported
	    dynasties[dynasties.length-1].name = _dynastyName;
		takeCrown(_heirName);
		emit DynastyStarted(msg.sender);
	}

	function abdication() private {

	}

	function abdicate() public payable onlyMonarch {
		require(msg.value >= activeMonarch.costOfCrown * abdicationCostPerc * 100);
		contractOwner.transfer(activeMonarch.costOfCrown * abdicationCostPerc * 100);
	}
	
	function changeAddr(address _newAddress) public onlyMonarch {
	    activeMonarch.addr = _newAddress;
	}
	
	//If this code gets updated, point to it here
	function setLatestContract(address _latestContract) public onlyContractOwner {
	    latestContract = _latestContract;
	}

}


/*
crown cost = 1000
cost for nextCrown = 1100
cost to abducate = 1000/20 = 50
crown cost = 500
cost for next crown = 550
somsone buys crown for 550, adbdicator pays half his money back
cost to abducate = 500/20 = 25
crown cost = 250

-----