import unittest
from domain.Book import Book
from domain.Author import Author

class Test_Book(unittest.TestCase):
    def test(self):
        self.assertTrue(True)


    def test_create(self):
        author = Author("Mihai", "Eminescu", 73)
        book = Book(author, "Luc", "1883", 12)
        self.assertEqual(author.get_name(), book.get_author().get_name())
        self.assertEqual(author.get_title(), book.get_author().get_title())
        self.assertEqual(author.get_year(), book.get_author().get_year())
        self.assertEqual(author.get_price(), book.get_author().get_price())

        self.assertRaisesRegex(ValueError, "*exception*", book.set_price(-1))

    def test_price(self):
        author = Author("T", "Pope", 73)
        book = Book(author, "nvim", "2023", -1)
        self.assertFalse(book.check_price(12, 12))
        book.set_price(12)
        self.assertTrue(book.check_price(11, 13))



if __name__ == '__main__':
    unittest.main()
