pragma solidity ^0.4.17;

contract SupplyChain {
	/**
	* Type used to encode the condition of a packet
	*/
	struct Condition {
		uint256 time;
		int humidity;
		int temperature;
	}
	/**
	* Type used to encode the packet
	*/
	struct Packet {
		bytes32 [] name;
		Condition[] condition;
		address Producer;
	}
	
	
	/** Keeps track of the first available id, it corresponds
	to the number of tracked packets */
	uint currentID = 0;
	/** The address of the contract creator */
	address creator;
	/** Mapping containing the list of all packets */
	mapping (uint => Packet) packets;


	/**
	* Contract Constructor
	*/
	function SupplyChain(){
		creator = msg.sender;
	}
	
	/**
	* Add a packet
	* @param packet_name the (unique?) name of a product type
	* @return the id of the correctly added packet
	*/
	function addPacket(bytes32 [] packet_name) returns (uint) {
		uint id = currentID;
		currentID = currentID + 1;
        packets[id] = Packet(
		    packet_name,
		    new Condition[](0),
		    msg.sender
		);
		return currentID;
	}
}