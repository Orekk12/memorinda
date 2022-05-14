// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract TicketFactory{
    // address[] public deployedTickets;

    constructor (string memory eventCaption, uint eventID){
        /*
        for (uint i = 0; i < ticketAmount; i++)
        {
            createTicket(eventCaption, eventID, cost, creator);
        }
        */
    }

    function createTicket(string memory eventCaption, uint eventID, uint cost, address creator) public {//TODO: restrict ticket creation to event managers??
        Ticket newTicket = new Ticket(eventCaption, eventID, cost, creator);
        // deployedTickets.push(newTicket);//TODO: map these tickets to events
    }

    function getDeployedTickets() public view returns(address[] memory) {
        // return deployedTickets;
    }
}

contract Ticket{

    string public _eventCaption;
    uint public _id;
    uint public _eventID;
    address public _eventManager;
    address public _owner;
    uint public _cost;
    bool public _onSale;

    modifier restricted() {
        require(msg.sender == _owner, "Error: Cannot change object properties, wrong owner");
        _;
    }

    constructor (string memory eventCaption, uint eventID, uint cost, address creator) public{
        _eventCaption = eventCaption;
        _eventID = eventID;
        _cost = cost;

        //TODO: set ticket id
        _onSale = true;
        _owner = creator;//set owner as event creator at ticket init
        _eventManager = creator;

    }

    function buy_ticket() public payable
    {
        require(_onSale == true, "Error: Ticket is not on sale.");
        require(msg.value == _cost, "Error: Ticket payment is not equal to ticket cost.");

        // _owner.transfer(msg.value);//transfer money to current owner
        _owner = msg.sender;//change owner to buyer
    }

    function setTicketSale(bool saleFlag) public restricted
    {
        //require(_owner == msg.sender, "Error: Cannot change ticket sale state, wrong user");//restriced checks it
        _onSale = saleFlag;
    }
}