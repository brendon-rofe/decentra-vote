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

}
