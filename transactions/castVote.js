export const CastVote = `
import Voting from 0x01;

transaction(candidateID: Int)
{
    prepare(voter: AuthAccount)
    {
        let ballot <- voter.load<@Voting.Ballot>(from: /storage/Ballot)!;
        ballot.vote(proposal: candidateID);
        Voting.cast(ballot: <- ballot);
        log("Vote Casted!");
    }
}
`;