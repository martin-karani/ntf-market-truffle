//SPDX-license-Identifier - MIT
pragma solidity >=0.4.22 <0.9.0;


interface IERC721 {
    function transferFrom(
        address from,
        address to,
        uint256 tokenID
    ) external;
}
