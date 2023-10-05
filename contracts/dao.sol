// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;
/// @title Simple DAO smart contract.

contract DAO {

    // Create an enum named Vote containing possible options for a vote
    enum Vote { NO, YES }

    // Create a mapping of ID => Proposal
    mapping(uint256 => Proposal) public proposals;
    // todo
    mapping(uint256 => string) public proposalNames;
    // Number of proposals that have been created
    uint256 public numProposals;
    
    // --------------------------------

    // Create a struct named Proposal containing all relevant information
    struct Proposal {
        // deadline - the UNIX timestamp until which this proposal is active. 
        // Proposal can be executed after the deadline has been exceeded.
        // uint256 deadline;
        // yayVotes - number of yay votes for this proposal
        uint256 yesVotes;
        // nayVotes - number of nay votes for this proposal
        uint256 noVotes;
        // executed - whether or not this proposal has been executed yet. 
        // Cannot be executed before the deadline has been exceeded.
        // bool executed;
    }

    function createProposal() public {
        // Set the proposal's voting deadline to be (current time + 5 minutes)
        // proposal.deadline = block.timestamp + 5 minutes;
        proposals[numProposals] = (Proposal( { yesVotes: 0, noVotes: 0 } ));
        numProposals++;
        // return numProposals - 1;
    }

    function voteOnProposal(uint256 proposalIndex, Vote vote) public {    
        Proposal storage proposal = proposals[proposalIndex];

        // todo
        // uint256 numVotes = 0;
        // require(numVotes > 0, "ALREADY_VOTED");
            
        if (vote == Vote.YES) {
            proposal.yesVotes += 1;
        } else {
            proposal.noVotes += 1;
        }
    }
}
