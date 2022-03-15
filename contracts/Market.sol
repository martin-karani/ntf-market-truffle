//SPDX-license-Identifier - MIT
pragma solidity >=0.4.22 <0.9.0;

import "./IERC721.sol";

contract Market {
    enum ListingStatus{
        Active,
        Sold,
        Cancelled
    }
    struct Listing{
        ListingStatus status;
        address seller;
        address  token;
        uint tokenId;
        uint price;
    }
    event Listed(
        uint listingId,
        address seller,
        address token,
        uint tokenId,
        uint price
    );
    event Sale(
        uint listingId,
        address buyer,
        address token,
        uint tokenId,
        uint price

    );
    event Cancel(
        uint listingId,
        address seller
    );
    uint private _listingId = 0;
    mapping(uint=>Listing) private _listings;

    function getListing(uint listingId) public view returns(Listing memory ){
        return _listings[listingId];
    }

    function listToken(address token,uint tokenId, uint price) public {
        IERC721(token).transferFrom(msg.sender,address(this),tokenId);
        Listing memory listing = Listing(
            ListingStatus.Active,
            msg.sender,
            token ,
            tokenId ,
            price
        );
        _listingId++;
        _listings[1] = listing;

        emit Listed(_listingId, msg.sender, listing.token, listing.tokenId, listing.price);
    }

    function buyToken(uint listingId) external payable{
        Listing storage listing = _listings[listingId];

        require(msg.sender != listing.seller,"Seller cannot be buyer");
        require(listing.status == ListingStatus.Active,"Listing is not active");
        require(msg.value >= listing.price,"Insufficient Payment");

        IERC721(listing.token).transferFrom(address(this),msg.sender,listing.tokenId);
        payable(listing.seller).transfer(listing.price);

        emit Sale(listingId, msg.sender, listing.token, listing.tokenId, listing.price);
    }

    function cancel(uint listingId) public{
        Listing storage listing =_listings[listingId];

        require(msg.sender == listing.seller,"Only Seller can cancel listing");
        require(listing.status == ListingStatus.Active,"Listing is not active");
        listing.status = ListingStatus.Cancelled;

        emit Cancel(listingId, msg.sender);

    }
}