from abc import ABC, abstractmethod;
from core.entities.user import User;
from typing import Optional, List;


class IUserRepository(ABC):
    
    # create users
    @abstractmethod
    def CreateUser(self, user_id: int, user_name: str, user_email: str, user_password: int):
        pass
    # get users
    @abstractmethod
    def GetUserbyID(self, user_id: int) -> Optional[User]:
        pass;
    
    @abstractmethod
    def GetUserbyName(self, user_name: str) -> Optional[User]:
        pass;
    
    @abstractmethod
    def GetUserbyEmail(self, user_email: str) -> Optional[User]:
        pass;
    
    @abstractmethod
    def GetListUsers(self) -> List[User]:
        pass;
    
    # add users
    @abstractmethod
    def AddUser(self, user: User) -> None:
        pass;
    
    # remove users
    @abstractmethod
    def RemoveUser(self, user: User) -> None:
        pass;
    
    # update users
    @abstractmethod
    def UpdateUser(self, user: User) -> None:
        pass;