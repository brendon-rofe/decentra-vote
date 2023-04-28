// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract DecentraVote {

    error NotRegistered();
    error HasAlreadyVoted();
    error NotCampaignCreator();
    error CampaignNotStarted();

    struct Campaign {
        uint id;
        address campaignCreator;
        string name;
        string description;
        uint nextCandidateId;
        mapping(uint => Candidate) candidates;
        uint numCandidates;
        mapping(address => bool) isRegistered;
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
        campaigns[nextCampaignId].campaignCreator = msg.sender;
        campaigns[nextCampaignId].name = _name;
        campaigns[nextCampaignId].description = _description;
        campaigns[nextCampaignId].nextCandidateId = 1;
        registerToVote(nextCampaignId);
        nextCampaignId++;
    }

    function startCampaign(uint _campaignId, uint _duration) 
        external
    {
        if(campaigns[_campaignId].campaignCreator != msg.sender) {
            revert NotCampaignCreator();
        }
        campaigns[_campaignId].startTime = block.timestamp;
        campaigns[_campaignId].endTime = block.timestamp + _duration;
    }

    function getCampaignDetails(uint _campaignId) 
        external view returns (uint, string memory, string memory, uint, uint, uint)
    {
        return (
            campaigns[_campaignId].id,
            campaigns[_campaignId].name,
            campaigns[_campaignId].description,
            campaigns[_campaignId].nextCandidateId,
            campaigns[_campaignId].startTime,
            campaigns[_campaignId].endTime
        );
    }

    function addCandidate(uint _campaignId, string memory _manifesto) external {
        uint id = campaigns[_campaignId].nextCandidateId;
        Candidate memory candidate;
        candidate.candidateAddress = msg.sender;
        candidate.campaignManifesto = _manifesto;
        campaigns[_campaignId].candidates[id] = candidate;
        campaigns[_campaignId].nextCandidateId++;
        campaigns[_campaignId].numCandidates++;
    }

    function getCandidate(uint _campaignId, uint _candidateId) 
        external view returns (Candidate memory)
    {
        return campaigns[_campaignId].candidates[_candidateId];
    }

    function removeCandidate(uint _campaignId, uint _candidateId) external {
        campaigns[_campaignId].numCandidates--;
        delete campaigns[_campaignId].candidates[_candidateId];
    }

    function registerToVote(uint _campaignId) public {
        voters[msg.sender].voterAddress = msg.sender;
        voters[msg.sender].participatingCampaigns.push(_campaignId);
        campaigns[_campaignId].isRegistered[msg.sender] = true;
    }

    function vote(uint _campaignId, uint _candidateId) external {
        if(campaigns[_campaignId].startTime == 0) {
            revert CampaignNotStarted();
        }
        if(!campaigns[_campaignId].isRegistered[msg.sender]) {
            revert NotRegistered();
        }
        if(campaigns[_campaignId].hasVoted[msg.sender]) {
            revert HasAlreadyVoted();
        }
        campaigns[_campaignId].hasVoted[msg.sender] = true;
        campaigns[_campaignId].candidates[_candidateId].numVotes++;
    }

}
