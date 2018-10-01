pragma solidity ^0.4.24;

contract Ownable {
    //Originally forked from OpenZeppelin
    
    address public contractOwner;
    
    event contractOwnershipRenounced(address indexed previousOwner);
    event contractOwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() public {
        contractOwner = msg.sender;
    }
    
    modifier onlyContractOwner() {
        require(msg.sender == contractOwner, "Not the contract owner");
        _;
    }
    
    function renounceContractOwnership() public onlyContractOwner {
        emit contractOwnershipRenounced(contractOwner);
        contractOwner = address(0);
    }
    
    function transferContractOwnership(address _newContractOwner) public onlyContractOwner {
        _transferContractOwnership(_newContractOwner);
    }
    
    //why not put this in transferContractOwnership?
    function _transferContractOwnership(address _newContractOwner) internal {
        require(_newContractOwner != address(0));
        emit contractOwnershipTransferred(contractOwner, _newContractOwner);
        contractOwner = _newContractOwner;
    }
    
}