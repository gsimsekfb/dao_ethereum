// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;
/// @title Simple DAO smart contract.

import "hardhat/console.sol";

contract Dao {

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
        string name;
        uint256 yesVotes;
        uint256 noVotes;                
        uint256 deadline; // the UNIX timestamp until which this proposal is open to voting 
    }

    function create_proposal(string memory name) public {
        Proposal storage proposal = proposals[numProposals];
        proposal.name = name;
        proposal.deadline = block.timestamp + 90 days;
        numProposals++;
    }

    // hint: https://www.unixtimestamp.com/
    function change_proposal_deadline(uint256 propId, uint256 unix_timestamp) public {
        Proposal storage proposal = proposals[propId];
        require(unix_timestamp > block.timestamp, "DEADLINE_IN_THE_PAST");
        proposal.deadline = unix_timestamp;
    }

    function change_proposal_name(uint256 propId, string memory name) public {
        // todo: reject empyt string
        require(name != " ", "DEADLINE_IN_THE_PAST");
        Proposal storage proposal = proposals[propId];
        proposal.name = name;
    }

    function vote_on_proposal(uint256 propId, Vote vote) public {
        require(voters[propId][msg.sender] == false, "ALREADY_VOTED");
        require(
            proposals[propId].deadline > block.timestamp,
            "DEADLINE_EXCEEDED"
        );
        Proposal storage proposal = proposals[propId];
        voters[propId][msg.sender] = true;
        console.log("%s voted for prop. id %d", msg.sender, propId);

        if (vote == Vote.YES) {
            proposal.yesVotes += 1;
        } else {
            proposal.noVotes += 1;
        }
    }

    // --------------------------------

}
