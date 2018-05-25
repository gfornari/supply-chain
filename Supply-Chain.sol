pragma solidity ^0.4.23;
/**
* 
*
*/
contract SupplyChain {
    struct State {
        uint64 timestamp;
        // This json will contain all details about the current condition,
        // e.g. temperature, humidity...
        string description; 
    }
    
    mapping(uint128 => State[]) public items;
    
    /**
     * Constructor is executed on contract creation
     */
    constructor() public {
        
    }
    
    function addItem(uint128 id, uint64 timestamp, string description) public {
        require(items[id].length == 0);
        items[id].push(State(timestamp, description));
    }
    
    function addState(uint128 id, uint64 timestamp, string description) public {
        require(items[id].length > 0);
        items[id].push(State(timestamp, description));
    }
    
}

