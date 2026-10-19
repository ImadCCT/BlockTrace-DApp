// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BlockTrace {

    struct Product {
        uint productId;
        string name;
        address producer;
        address currentOwner;
        string status;
        uint timestamp;
    }

    mapping(uint => Product) public products;

    event ProductRegistered(
        uint productId,
        string name,
        address producer
    );

    event ProductTransferred(
        uint productId,
        address sender,
        address receiver
    );

    event StatusUpdated(
        uint productId,
        string status
    );

    function registerProduct(
    uint _productId,
    string memory _name
) public {

    require(
        _productId != 0,
        "Product ID cannot be zero"
    );

    require(
        bytes(_name).length > 0,
        "Product name cannot be empty"
    );

    require(
        products[_productId].productId == 0,
        "Product already exists"
    );

    products[_productId] = Product(
        _productId,
        _name,
        msg.sender,
        msg.sender,
        "Produced",
        block.timestamp
    );

    emit ProductRegistered(
        _productId,
        _name,
        msg.sender
    );
}

    function transferProduct(
        uint _productId,
        address _receiver
    ) public {

        require(
            products[_productId].productId != 0,
            "Product does not exist"
        );

        require(
            products[_productId].currentOwner == msg.sender,
            "Only current owner can transfer"
        );

        require(
            _receiver != address(0),
            "Invalid receiver"
        );

        address previousOwner = products[_productId].currentOwner;

        products[_productId].currentOwner = _receiver;
        products[_productId].status = "In Transit";
        products[_productId].timestamp = block.timestamp;

        emit ProductTransferred(
            _productId,
            previousOwner,
            _receiver
        );
    }

    function updateStatus(
        uint _productId,
        string memory _status
    ) public {

        require(
            products[_productId].productId != 0,
            "Product does not exist"
        );

        require(
            products[_productId].currentOwner == msg.sender,
            "Only current owner can update status"
        );

          require(
            bytes(_status).length > 0,
            "Status cannot be empty"
        );

        products[_productId].status = _status;
        products[_productId].timestamp = block.timestamp;

        emit StatusUpdated(
            _productId,
            _status
        );
    }

    function getProduct(
        uint _productId
    )
        public
        view
        returns (
            uint,
            string memory,
            address,
            address,
            string memory,
            uint
        )
    {
        require(
            products[_productId].productId != 0,
            "Product does not exist"
        );

        Product memory product = products[_productId];

        return (
            product.productId,
            product.name,
            product.producer,
            product.currentOwner,
            product.status,
            product.timestamp
        );
    }
}