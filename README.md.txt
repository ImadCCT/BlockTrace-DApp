Project Overview

BlockTrace-DApp is a Solidity smart contract for tracking products on a blockchain.

Product Information

Each product stores:

Product ID

Product name

Producer address

Current owner's address

Product status

Last update timestamp

Smart Contract Functions

registerProduct() — Registers a new product.

transferProduct() — Transfers ownership and sets the status to "In Transit".

updateStatus() — Allows the current owner to update the product status.

getProduct() — Retrieves the details of a registered product.