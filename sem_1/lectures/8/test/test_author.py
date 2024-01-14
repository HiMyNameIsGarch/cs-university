import unittest

class Test_Author(unittest.TestCase):
    def __init__(self, methodName: str = "runTest") -> None:
        super().__init__(methodName)

    def test(self):
        self.assertTrue(True)

if __name__ == '__main__':
    unittest.main()


