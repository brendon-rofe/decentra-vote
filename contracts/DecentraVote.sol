// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract DecentraVote {

    struct Campaign {
        uint id;
        string name;
        string description;
        uint nextCandidateId;
        mapping(uint => Candidate) candidates;
        mapping(address => bool) hasVoted;
    }

    uint public nextCampaignId = 1;
    mapping(uint => Campaign) public campaigns;

    struct Candidate {
        address candidateAddress;
        string campaignManifesto;
        uint numVotes;
    }

    struct Voter {
        address voterAddress;
        uint[] participatingCampaigns;
    }

    mapping(address => Voter) public voters;

    function createCampaign(string memory _name, string memory _description) external {
        campaigns[nextCampaignId].id = nextCampaignId;
        campaigns[nextCampaignId].name = _name;
        campaigns[nextCampaignId].description = _description;
        campaigns[nextCampaignId].nextCandidateId = 1;
        nextCampaignId++;
    }

}
