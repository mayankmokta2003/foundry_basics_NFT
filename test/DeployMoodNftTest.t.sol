// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployMoodNft} from "../script/DeployMoodNft.s.sol";

contract DeployMoodNftTest is Test {

    DeployMoodNft public deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    // function testConvertSvgToUri() public view {
    //     string memory expectedUri = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdodD0iNTAwIiB3aWR0aD0iNTAwIj4KPHRleHQgeD0iMCIgeT0iMTUiIGZpbGw9IiNlNDE5MTkiPiBoZWxsbyBteSBuYW1lIGlzIE1heWFuayA8L3RleHQ+Cjwvc3ZnPg==";
    //     string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" height="500" width="500"><text x="0" y="15" fill="#e41919"> hello my name is Mayank </text></svg>';
    //     string memory actualUri = deployer.svgToImageURI(svg);

    //     assert(keccak256(abi.encodePacked(expectedUri)) == keccak256(abi.encodePacked(actualUri))
    //     );
    // }


    function testConvertSvgToUri() public view {
    string memory expectedUri = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdodD0iNTAwIiB3aWR0aD0iNTAwIj48dGV4dCB4PSIwIiB5PSIxNSIgZmlsbD0iI2U0MTkxOSI+IGhlbGxvIG15IG5hbWUgaXMgTWF5YW5rIDwvdGV4dD48L3N2Zz4=";
    string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" height="500" width="500"><text x="0" y="15" fill="#e41919"> hello my name is Mayank </text></svg>';
    string memory actualUri = deployer.svgToImageURI(svg);

    assert(keccak256(abi.encodePacked(expectedUri)) == keccak256(abi.encodePacked(actualUri)));
}



}