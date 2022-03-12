//SPDX-license-Identifier - MIT

pragma solidity ^0.8.9;

contract Market{
    struct Listing{
        address  token;
        uint tokenId;
        uint price;
    }

    uint private _listingId = 0;
    mapping(uint=>Listing) private _listings;

    function listToken(address token,uint tokenId, uint price) public {
        Listing memory listing = Listing(
            token ,
            tokenId ,
            price
        );
        _listingId++;
        _listings[1] = listing;
    }

    function buyToken(uint listingId) external{}
}