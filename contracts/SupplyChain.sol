pragma solidity ^0.4.17;
/**
* 
*
*/
contract SupplyChain {
	/**
	* Type used to encode the condition of a packet
	* 
	* @TODO: add all paremeters we'll keep track of
	*/
	struct Condition {
		uint256 time;
		uint8 humidity;
		uint8 temperature;
		address producer;
		/* add other conditions here */
	}
	/**
	* Type used to encode the packet
	*/
	struct Packet {
		bytes32 [] name;
		uint8 conditionID;
		mapping(uint8 => Condition) condition;
		address producer;
	}
	
	
	/** Keeps track of the first available id, it corresponds
	to the number of tracked packets */
	uint8 currentID = 0;
	/** The address of the contract creator */
	address creator;
	/** Mapping containing the list of all packets */
	mapping (uint8 => Packet) packets;


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
	function addPacket(bytes32 [] packet_name) returns (uint8) {
		uint8 id = currentID;
		currentID = currentID + 1;

        packets[id] = Packet(
	        {
			    name: packet_name,
			    conditionID: 0,
			    producer: msg.sender
			}
		);
		//Add initial condition
		addCondition(id, 0, 0); 
		return currentID;
	}

	/**
	* Add condition to an existing packet
	*/
	function addCondition(uint8 id, uint8 humidity, uint8 temperature) returns (bool,
	string) {
	    if(id > currentID) {
	        /* The packet is not instantiated --> Return false and do nothing */
	        return (false, "Cannot add condition to a not existing packet");
	    }
		uint8 conditionID = packets[id].conditionID;
		packets[id].condition[conditionID] = Condition(
		{
			time: now,
			temperature: temperature,
			humidity: humidity,
			producer: msg.sender
		});
		return (true, "ok");
	}
}
