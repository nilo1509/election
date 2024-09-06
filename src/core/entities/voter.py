from core.entities.data_classes import DataVoter, DataVote
from dataclasses import dataclass;

class Voter:
    def __init__(self, voter_data: DataVoter, vote_data: DataVote):
        self.cardNumber = voter_data.cardNumber;
        self.name = voter_data.name;
        self.voteNumber = vote_data.voteNumber;
        self.votePermission = vote_data.votePermission;
        self.votePosition = vote_data.votePosition;
        self.voteNone = vote_data.voteNone;
        self.voteNull = vote_data.voteNull;