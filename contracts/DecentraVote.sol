// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DecentraVote {

    struct Campaign {
        uint id;
        string name;
        string description;
        address creator;
        bool isActive;
        uint start;
        uint end;
        mapping(uint => Candidate) candidates;
        mapping(address => bool) hasVoted;
        uint candidateCount;
        uint totalVotes;
    }

    uint public nextCampaignId = 1;
    mapping(uint => Campaign) private campaigns;

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    struct Voter {
        address id;
        string votedFor;
    }

    function createCampaign(
        string memory _name, 
        string memory _desc
    ) external {
        campaigns[nextCampaignId].id = nextCampaignId;
        campaigns[nextCampaignId].name = _name;
        campaigns[nextCampaignId].description = _desc;
        campaigns[nextCampaignId].creator = msg.sender;
        nextCampaignId++;
    }

}
