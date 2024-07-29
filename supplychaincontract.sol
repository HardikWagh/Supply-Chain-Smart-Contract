// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {
    // Structures
    struct Product {
        uint productId;
        string productName;
        uint ownerId;
        address owner;
    }

    struct Participant {
        uint participantId;
        string participantName;
        string participantType; // e.g., Manufacturer, Supplier, Consumer
        address participantAddress;
    }

    struct Ownership {
        uint productId;
        uint[] participantIds; // Array to keep track of the ownership chain
    }

    // Global Variables
    uint public productId;
    uint public participantId;
    uint public ownerId;

    // Mappings to store participants, products, and ownerships
    mapping(uint => Product) public products;
    mapping(uint => Participant) public participants;
    mapping(uint => Ownership) public ownerships;

    // Events
    event ParticipantAdded(uint participantId, string participantName);
    event ProductAdded(uint productId, string productName, address owner);
    event OwnershipTransferred(uint productId, uint newOwnerId);

    // Add Participant
    function addParticipant(string memory _participantName, string memory _participantType) public {
        participantId++;
        participants[participantId] = Participant(participantId, _participantName, _participantType, msg.sender);
        emit ParticipantAdded(participantId, _participantName);
    }

    // Get Participant
    function getParticipant(uint _participantId) public view returns (Participant memory) {
        return participants[_participantId];
    }

    // Add Product
    function addProduct(string memory _productName) public {
        productId++;
        products[productId] = Product(productId, _productName, participantId, msg.sender);
        ownerships[productId].productId = productId;
        ownerships[productId].participantIds.push(participantId);
        emit ProductAdded(productId, _productName, msg.sender);
    }

    // Get Product
    function getProduct(uint _productId) public view returns (Product memory) {
        return products[_productId];
    }

    // Transfer Ownership
    function newOwner(uint _productId, uint _newOwnerId) public {
        require(msg.sender == products[_productId].owner, "Only the current owner can transfer ownership");
        products[_productId].ownerId = _newOwnerId;
        products[_productId].owner = participants[_newOwnerId].participantAddress;
        ownerships[_productId].participantIds.push(_newOwnerId);
        emit OwnershipTransferred(_productId, _newOwnerId);
    }

    // Get Provenance
    function getProvenance(uint _productId) public view returns (uint[] memory) {
        return ownerships[_productId].participantIds;
    }

    // Get Ownership
    function getOwnership(uint _productId) public view returns (uint) {
        return products[_productId].ownerId;
    }

    // Authenticate Participant
    function authenticateParticipant(uint _participantId) public view returns (bool) {
        if (participants[_participantId].participantAddress == msg.sender) {
            return true;
        }
        return false;
    }
}
