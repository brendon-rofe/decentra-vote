// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract DecentraVote {

<<<<<<< HEAD
    
=======
    event CampaignCreated(uint indexed campaignId, string name);
    event CandidateRegistered(uint indexed campaignId, uint indexed candidateId, string name);

    error NotCampaignCreator();
    error VoterAlreadyRegistered();
    error CandidateAlreadyRegistered();
    error HasAlreadyVoted();
    error CampaignEnded();
    error VoterNotRegistered();

    struct Campaign {
        uint id;
        string name;
        string description;
        address creator;
        uint start;
        uint end;
        uint nextCandidateId;
        mapping(uint => Candidate) candidates;
        mapping (address => bool) voterRegistered;
        mapping(string => bool) candidateRegistered;
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
        if(campaigns[_campaignId].candidateRegistered[_name]) {
            revert CandidateAlreadyRegistered();
        }
        _;
    }

    modifier voterAlreadyRegistered(uint _campaignId, address _voterAddr) {
        if(campaigns[_campaignId].voterRegistered[_voterAddr]) {
            revert VoterAlreadyRegistered();
        }
        _;
    }

    modifier voterIsRegistered(uint _campaignId, address _voterAddr) {
        if(!campaigns[_campaignId].voterRegistered[_voterAddr]) {
            revert VoterNotRegistered();
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
        campaigns[_campaignId].candidateRegistered[_name] = true;
        campaigns[_campaignId].candidateCount++;
        emit CandidateRegistered(_campaignId, candidateId, _name);
        campaigns[_campaignId].nextCandidateId++;
    }

    function vote(uint _campaignId, uint _candidateId)
        external
        voterIsRegistered(_campaignId, msg.sender)
        hasAlreadyVoted(_campaignId)
        campaignEnded(_campaignId)
    {
        campaigns[_campaignId].candidates[_candidateId].voteCount++;
        campaigns[_campaignId].totalVotes++;
        campaigns[_campaignId].hasVoted[msg.sender] = true;
    }
>>>>>>> 8aa40c81531e1d31adefdb24d0020617ad583391

    function regsiterVoter(uint _campaignId) 
        external voterAlreadyRegistered(_campaignId, msg.sender)
    {
        campaigns[_campaignId].voterRegistered[msg.sender] = true;
    }

}
