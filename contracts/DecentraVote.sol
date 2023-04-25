// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract DecentraVote {

    event CampaignCreated(uint indexed campaignId, string name);
    event CandidateRegistered(uint indexed campaignId, uint indexed candidateId, string name);

    error NotCampaignCreator();
    error CandidateAlreadyRegistered();
    error HasAlreadyVoted();
    error CampaignEnded();

    struct Campaign {
        uint id;
        string name;
        string description;
        address creator;
        uint start;
        uint end;
        uint nextCandidateId;
        mapping(uint => Candidate) candidates;
        mapping(string => bool) isRegistered;
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

    modifier candidateAlreadyRegistered(uint _campaignId, string memory _name) {
        if(campaigns[_campaignId].isRegistered[_name]) {
            revert CandidateAlreadyRegistered();
        }
        _;
    }

    modifier hasAlreadyVoted(uint _campaignId) {
        if(campaigns[_campaignId].hasVoted[msg.sender] == true) {
            revert HasAlreadyVoted();
        }
        _;
    }

    modifier campaignEnded(uint _campaignId) {
        if(campaigns[_campaignId].end < block.timestamp) {
            revert CampaignEnded();
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
        campaigns[nextCampaignId].nextCandidateId = 1;
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

    function registerCandidate(uint _campaignId, string memory _name)
        external candidateAlreadyRegistered(_campaignId, _name)
    {
        Candidate memory newCandidate;
        uint candidateId = campaigns[_campaignId].nextCandidateId + 1;
        newCandidate.id =candidateId;
        newCandidate.name = _name;
        campaigns[_campaignId].candidates[candidateId] = newCandidate;
        campaigns[_campaignId].isRegistered[_name] = true;
        campaigns[_campaignId].candidateCount++;
        emit CandidateRegistered(_campaignId, candidateId, _name);
        campaigns[_campaignId].nextCandidateId++;
    }

    function vote(uint _campaignId, uint _candidateId)
        external 
        hasAlreadyVoted(_campaignId)
        campaignEnded(_campaignId)
    {
        campaigns[_campaignId].candidates[_candidateId].voteCount++;
        campaigns[_campaignId].totalVotes++;
        campaigns[_campaignId].hasVoted[msg.sender] = true;
    }

}
