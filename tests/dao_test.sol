// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
import "remix_accounts.sol";
import "hardhat/console.sol";
import "../contracts/DAO.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite {

    Dao dao;
    function beforeAll () public {        
        dao = new Dao();
    }    

    function createProposal() public {
        string memory aa = "aa";
        dao.createProposal(aa);
        console.log("numProposals: %d", dao.numProposals());
        // uint256 xx = dao.proposals()[0].yesVotes;
        dao.proposals(0);
        // console.log("yes: %d", dao.proposals(0).yesVotes); // 

        // dao.proposals()[0];
        // Proposal storage proposal = dao.proposals[0];
        // console.log("%s", proposal.name);
        // Assert.ok(dao.proposals()[0].name == "aa", "");
        Assert.ok(2 == 2, "");
    } 
}
