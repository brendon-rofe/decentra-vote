// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DecentraVote {

    struct Candidate {
        address candidateAddr;
        string name;
        string campaignDesc;
    }

    error CandidateAlreadyExists();

    mapping(address => Candidate) public candidates;
    address[] public candidateAddrs;

    function registerAsCandidate(
        address _addr,
        string memory _name,
        string memory _campaignDesc
    ) external {
        if(candidates[_addr].candidateAddr == _addr) {
            revert CandidateAlreadyExists();
        }
        Candidate memory newCandidate;
        newCandidate.candidateAddr = _addr;
        newCandidate.name = _name;
        newCandidate.campaignDesc = _campaignDesc;
        candidates[_addr] = newCandidate;
        candidateAddrs.push(_addr);
    }

}
