export const InitializeProposals = `
import Voting from 0x01;

transaction 
{
  prepare(admin: AuthAccount) 
  {
    let adminRef = admin.borrow<&Voting.Administrator>(from: /storage/VotingAdmin)!;
    adminRef.initializeProposals(["Candidate 1", "Candidate 2"]);
  }

  post 
  {
    Voting.proposals.length == 2;
  }
}
`;