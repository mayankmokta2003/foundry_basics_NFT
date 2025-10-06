// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Base64} from "../lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    // errors
    error MoodNft__CanFlipMoodIfNotOwner();

    uint256 private s_tokenCounter;
    string private s_happySvgImageUri;
    string private s_sadSvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokeIdToMood;

    constructor(string memory happySvgImageUri, string memory sadSvgImageUri) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_happySvgImageUri = happySvgImageUri;
        s_sadSvgImageUri = sadSvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokeIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function flipMood(uint256 tokenId) public {
        // we want that only nft owner can change the mood
        // if(!_isApprovedOrOwner(msg.sender , tokenId)){
        if (getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender) {
            revert MoodNft__CanFlipMoodIfNotOwner();
        }
        if (s_tokeIdToMood[tokenId] == Mood.HAPPY) {
            s_tokeIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokeIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokeIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes( /* in order to decode first we will make it bytes and the through
                                    base64 we will convert it decoded string then we will add
                                    baseuri function then again encode the make it string */
                        abi.encodePacked(
                            '{"name": "',
                            name(),
                            '" ,"description": "An NFT that represents owner mood", "attributes" : [{"trait_type": "moodiness" , "value":100}] , "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }
}
