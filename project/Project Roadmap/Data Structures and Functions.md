## Data Structures

Campaign(struct): 
	- id (uint)
	- name (string)
	- description (string)
	- startTime (uint)
	- endTime (uint)
	- active (bool)
	- numCandidates (uint)
	- candidates (mapping)

Candidate (struct):
	id (uint)
	name (string)
	voteCount (uint)

Voter (struct):
	voterAddress (address)
	isRegistered (bool)
	participatedCampaigns

campaigns (mapping)
hasVoted (mapping)

## Functions

createCampaign
addCandidate
vote
getCandidate
registerVoter
unregisterVoter
isVoterRegistered