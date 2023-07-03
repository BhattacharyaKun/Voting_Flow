pub contract Voting
{
    pub var proposals: [String];
    pub let votes: {Int: Int};

    init()
    {
        self.proposals = [];
        self.votes = {};

        self.account.save<@Administrator>(<-create Administrator(), to: /storage/VotingAdmin)
    }

    pub resource Ballot 
    {
        pub let proposals: [String];
        pub var choices: {Int: Bool};

        init()
        {
            self.proposals = Voting.proposals;
            self.choices = {};

            var i = 0;
            while i < self.proposals.length 
            {
                self.choices[i] = false;
                i = i + 1;    
            }
        }

        pub fun vote(proposal: Int)
        {
            pre 
            {
                self.proposals[proposal] != nil : "Can't vote for that doesn't exist!";
            }

            self.choices[proposal] = true;
        }
    }

    pub resource Administrator 
    {
        pub fun initializeProposals(_ proposals: [String])
        {
            pre 
            {
                Voting.proposals.length == 0: "Proposals can only be initialized once!";
                proposals.length > 0: "Can't initialize no proposals";    
            }

            Voting.proposals = proposals;

            var i = 0;
            while i < proposals.length 
            {
                Voting.votes[i] = 0;
                i = i + 1;    
            }
        }    

        pub fun issueBallot(): @Ballot
        {
            return <- create Ballot();
        }
    }

    pub fun cast(ballot: @Ballot)
    {
        var i = 0;
        while i < self.proposals.length
        {
            if ballot.choices[i]!
            {
                self.votes[i] = self.votes[i]! + 1;
            }
            i = i + 1;
        }
        destroy ballot;
    }
}