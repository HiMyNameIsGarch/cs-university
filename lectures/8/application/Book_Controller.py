from domain.Book import Book


class Book_Controller:
    def __init__(self, br, ar):
        self.__book_repo = br
        self.__author_repo = ar

    def add_book(self, book:Book):
        self.__book_repo.add_book(book)
        if not self.__author_repo.contains(book.get_author()):
            self.__author_repo.add(book.get_author())


