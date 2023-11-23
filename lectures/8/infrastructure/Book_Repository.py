from domain.Book import Book

class Book_Repository:
    def __init__(self) -> None:
        self.__books:list[Book] = []

    def add_book(self, b:Book):
        self.__books.append(b)

    def sort_books_by_price(self):
        self.__books.sort(key=lambda x: x.__price, reverse=True)

    def filter_books_by_title(self, title):
        return [b for b in self.__books if b.__title.__contains__(title)]


