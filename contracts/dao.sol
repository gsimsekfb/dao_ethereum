// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;
/// @title Simple DAO smart contract.

import "hardhat/console.sol";

contract DAO {

    enum Vote { NO, YES }

    // Create a mapping of ID => Proposal
    mapping(uint256 => Proposal) public proposals;
    // Number of proposals that have been created
    uint256 public numProposals;
    
    //  Todo
    // mapping(address => bool) []  // array index is proposal ID
    // or better use C++ std::set e.g. [proposal ID, hash_set of addresses)], we do not need bools
    // proposal ID => (voter_addr => voted)
    mapping(uint256 => mapping(address => bool)) public voters;
    uint256[] public arr;

    // --------------------------------

    // Create a struct named Proposal containing all relevant information
    struct Proposal {
        uint256 yesVotes;
        uint256 noVotes;
        string name;
    }

    function createProposal(string memory name) public {
        Proposal storage proposal = proposals[numProposals];
        proposal.name = name;
        numProposals++;
    }

    function voteOnProposal(uint256 propId, Vote vote) public {
        require(voters[propId][msg.sender] == false, "ALREADY_VOTED");
 
        Proposal storage proposal = proposals[propId];
        voters[propId][msg.sender] = true;
        console.log("%s voted for prop. id %d", msg.sender, propId);

        if (vote == Vote.YES) {
            proposal.yesVotes += 1;
        } else {
            proposal.noVotes += 1;
        }
    }
}
