// SPDX-License-Identifier: Unlicensed

pragma solidity >0.7.0 <=0.9.0;

contract CampaignFactory {
    address[] public deployedCampaigns;

    event campaignCreated(
        string title,
        uint requiredAmount,
        address indexed owner,
        // address vendor,
        address campaignAddress,
        string imgURI,
        uint indexed timestamp,
        string indexed category
    );


    function createCampaign(
        string memory campaignTitle,
        uint requiredCampaignAmount,
        string memory imgURI,
        string memory category,
        string memory storyURI
        // address payable vendor
    ) public
    {

        Campaign newCampaign = new Campaign(
            campaignTitle, requiredCampaignAmount, imgURI, storyURI, msg.sender
            // vendor
        );


        deployedCampaigns.push(address(newCampaign));

        emit campaignCreated(
            campaignTitle,
            requiredCampaignAmount,
            msg.sender,
            address(newCampaign),
            imgURI,
            block.timestamp,
            category
        );
    }
}


contract Campaign {
    string public title;
    uint public requiredAmount;
    string public image;
    string public story;
    address payable  public owner;
    // address payable public vendor;
    uint public receivedAmount;

    event donated(address indexed donar, uint indexed amount, uint indexed timestamp);

    constructor(
        string memory campaignTitle,
        uint requiredCampaignAmount,
        string memory imgURI,
        string memory storyURI,
        address campaignOwner
        // address campaignVendor
    ) {
        title = campaignTitle;
        requiredAmount = requiredCampaignAmount;
        image = imgURI;
        story = storyURI;
        owner = payable(campaignOwner);
        // vendor = payable(campaignVendor);
    }

    function donate() public payable {
        require(requiredAmount > receivedAmount, "required amount fullfilled");
        owner.transfer(msg.value);
        receivedAmount += msg.value;
        emit donated(msg.sender, msg.value, block.timestamp);
    }
}

