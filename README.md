# Supply-Chain-Smart-Contract
This repository includes the solidity smart contract for a supply chain.
Following is the algorithm for the contract:
1. Initialize Structures:
    -Define "Product", "Participant", and "Ownership" structures.
2. Initialize Global Variables:
    -Define global variables for "productId", "participantId", and "ownerId".
3. Create Mappings:
    -Create mappings to store products, participants, and ownerships.
4. Define Events:
    -Define events for adding participants, adding products, and transferring ownership.
5. Add Participant:
    -Increment "participantId".
    -Add a new participant to the "participants" mapping.
    -Emit "ParticipantAdded" event.
6. Get Participant:
    -Return the participant details from the "participants" mapping based on "participantId".
7.Add Product:
    -Increment "productId".
    -Add a new product to the "products" mapping.
    -Initialize the "Ownership: structure for the product.
    -Add the current participant to the ownership chain.
    -Emit "ProductAdded" event.
8. Get Product:
    -Return the product details from the "products" mapping based on "productId".
9.Transfer Ownership:
    -Ensure only the current owner can transfer ownership.
    -Update the owner details in the "products" mapping.
    -Add the new owner to the ownership chain.
    -Emit "OwnershipTransferred" event.
10. Get Provenance:
    -Return the ownership chain from the "ownerships" mapping based on "productId".
11. Get Ownership:
    -Return the current owner ID of the product from the "products" mapping based on "productId".
12. Authenticate Participant:
    -Verify if the participant address matches the sender address.
