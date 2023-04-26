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
        uint startTime;
        uint endTime;
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

    function startCampaign(uint _duration) external {
        campaigns[nextCampaignId].startTime = block.timestamp;
        campaigns[nextCampaignId].endTime = block.timestamp + _duration;
    }

    function addCandidate(uint _campaignId, string memory _manifesto) external {
        uint id = campaigns[_campaignId].nextCandidateId;
        Candidate memory candidate;
        candidate.candidateAddress = msg.sender;
        candidate.campaignManifesto = _manifesto;
        campaigns[_campaignId].candidates[id] = candidate;
        campaigns[_campaignId].nextCandidateId++;
    }

}
