from core.interfaces.repositories.political_party_repository import IPoliticalPartyRepository;
from core.entities.political_party import PoliticalParty;

class CreateUser:
    def __init__(self, PoliticalPartyRepository: IPoliticalPartyRepository):
        self._political_party_repository = PoliticalPartyRepository;
        
    def execute(self, political_party_data: dict) -> None:
        self.verify_required_fields(political_party_data);
        
        political_party = PoliticalParty(
            name = political_party_data['name'],
            partyPicture = political_party_data['partyPicture'],
            candidateList = political_party_data['candidateList']
        )

        self._political_party_repository.CreateUser(political_party);
        
    def verify_required_fields(self, political_party_data: dict) -> None:
        required_fields = ['name', 'partyPicture', 'candidateList'];
        
        for field in required_fields:
            if field not in political_party_data or not political_party_data[field]:
                raise ValueError(f"The {field} data can't be empty"); 