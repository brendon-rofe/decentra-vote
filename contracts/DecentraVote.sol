// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DecentraVote {

    event CampaignCreated(uint indexed campaignId, string name);

    error NotCampaignCreator();

    struct Campaign {
        uint id;
        string name;
        string description;
        address creator;
        uint start;
        uint end;
        mapping(uint => Candidate) candidates;
        mapping(address => bool) hasVoted;
        uint candidateCount;
        uint totalVotes;
    }

    uint public nextCampaignId = 1;
    mapping(uint => Campaign) public campaigns;

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    struct Voter {
        address id;
        string votedFor;
    }

    modifier onlyCampaignCreator(uint _campaignId) {
        if(campaigns[_campaignId].creator != msg.sender) {
            revert NotCampaignCreator();
        }
        _;
    }

    function createCampaign(
        string memory _name, 
        string memory _desc
    ) external {
        campaigns[nextCampaignId].id = nextCampaignId;
        campaigns[nextCampaignId].name = _name;
        campaigns[nextCampaignId].description = _desc;
        campaigns[nextCampaignId].creator = msg.sender;
        emit CampaignCreated(nextCampaignId, _name);
        nextCampaignId++;
    }

    function startCampaign(uint _campaignId, uint _duration) 
        external onlyCampaignCreator(_campaignId) 
    {
        campaigns[_campaignId].start = block.timestamp;
        campaigns[_campaignId].end = block.timestamp + _duration;
    }

}
