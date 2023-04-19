// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DecentraVote {

    event ElectionCreated(uint indexed electionId, string electionName);

    struct Election {
        string name;
        string description;
        uint start;
        uint end;
        address[] candidates;
    }

    uint public nextEelectionId = 1;
    mapping(uint => Election) public elections;

    struct Candidate {
        address candidateAddr;
        string name;
        string campaignDesc;
    }

    error CandidateAlreadyExists();

    mapping(address => Candidate) public candidates;
    address[] public candidateAddrs;

    modifier isCandidate(address _addr) {
        for(uint i = 0; i < candidateAddrs.length; i++) {
            if(candidates[_addr].candidateAddr == _addr) {
                revert CandidateAlreadyExists();
            }
        }
        _;
    }

    function registerAsCandidate(
        address _addr,
        string memory _name,
        string memory _campaignDesc
    ) external isCandidate(_addr) {
        Candidate memory newCandidate;
        newCandidate.candidateAddr = _addr;
        newCandidate.name = _name;
        newCandidate.campaignDesc = _campaignDesc;
        candidates[_addr] = newCandidate;
        candidateAddrs.push(_addr);
    }

    function createElection(
        string memory _name,
        string memory _desc,
        uint _start,
        uint _end,
        address[] memory _candidates
    ) external {
        Election memory newElection;
        newElection.name = _name;
        newElection.description = _desc;
        newElection.start = _start;
        newElection.end = _end;
        newElection.candidates = _candidates;
        elections[nextEelectionId] = newElection;
        emit ElectionCreated(nextEelectionId, _name);
        nextEelectionId++;
    }

}
