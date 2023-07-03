export const GetData = `
import Voting from 0x01;

pub fun main() 
{
  log("Votes for 0: ");
  log(Voting.proposals[0]);
  log(Voting.votes[0]);

  log("Votes for 1: ");
  log(Voting.proposals[1]);
  log(Voting.votes[1]);
}
`;