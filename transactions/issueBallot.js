export const IssueBallot = `
import Voting from 0x01;

transaction
{
    prepare(admin: AuthAccount, voter: AuthAccount)
    {
        let adminRef = admin.borrow<&Voting.Administrator>(from: /storage/VotingAdmin)!;
        let ballot <- adminRef.issueBallot();

        voter.save<@Voting.Ballot>(<-ballot, to: /storage/Ballot);
        log("Ballot transfered to the voter!");
    }
}
`;