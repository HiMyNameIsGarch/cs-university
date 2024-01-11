from domain.Team import Team
from typing import List, Optional
from domain.Team import Category

class TeamRepository:
    def __init__(self, teams:Optional[List[Team]]) -> None:
        if teams is None:
            teams = []
        self.__teams = teams
        self.__no_of_teams = len(teams)

    @property
    def no_of_teams(self) -> int:
        return self.__no_of_teams

    def sort_teams(self) -> List[Team]: # Baby stuff?
        filtered_teams = self.filter_teams().teams or []
        filtered_teams.sort(key=lambda x: x.score, reverse=True)
        return filtered_teams

    def filter_teams(self):
        lst = []
        for i in self.__teams:
            if i.category == Category.FIRST:
                lst.append(i)

        # return filter(lambda x: x.category == Category.FIRST, self.__teams) # boring way

        return TeamRepository(lst) # WHY?

    def add_team(self, team:Team) -> None:
        if team in self.__teams:
            raise ValueError("Team already exists")

        self.__teams.append(team)
        self.__no_of_teams += 1

    @property
    def teams(self) -> Optional[List[Team]]:
        return self.__teams

    def print(self):
        t1 = Team("1", 12)
        t2= Team("2", 14)
        t3 = Team("3", 15)

