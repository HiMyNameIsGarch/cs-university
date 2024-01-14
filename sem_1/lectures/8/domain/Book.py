from domain.Author import Author

class Book:
    def __init__(self, a, t, y, p) -> None:
        self.__author:Author = a
        self.__title:str = t
        self.__year:int = y
        self.__price:float = p

    def check_price(self, lb, ub):
        return (self.__price >= lb) and (self.__price <= ub)

    def __contains__(self, w):
        return w in self.__title
