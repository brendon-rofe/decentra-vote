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

}
