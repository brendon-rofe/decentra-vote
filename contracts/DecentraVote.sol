// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DecentraVote {

    struct Campaign {
        uint id;
        string name;
        string description;
        bool isActive;
        uint start;
        uint end;
        mapping(uint => Candidate) candidates;
        mapping(address => bool) hasVoted;
        uint candidateCount;
        uint totalVotes;
    }

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    struct Voter {
        address id;
        string votedFor;
    }

}
