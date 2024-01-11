from enum import Enum

class Category(Enum):
    FIRST = 0
    SECOND = 0

class Team:
    def __init__(self, name:str="Default team", score:int = 0, category:Category=Category.FIRST):
        self.__name = name
        if score < 0:
            raise ValueError("Score must be a positive number")
        self.__score = score
        self.__category = category

    @property
    def category(self) -> Category:
        return self.__category

    @category.setter
    def category(self, category:Category):
        self.__category = category

    @property
    def name(self) -> str:
        return self.__name

    @name.setter
    def name(self, name:str):
        self.__name = name

    @property
    def score(self) -> int:
        return self.__score

    @score.setter
    def score(self, new_score:int):
        if new_score < 0:
            raise ValueError("Score must be a positive number")
        self.__score = new_score

    def __str__(self) -> str:
        return f"{self.name} - {self.score}"

    __repr__ = __str__

