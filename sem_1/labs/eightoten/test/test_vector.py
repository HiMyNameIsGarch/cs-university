import unittest
from domain.my_vector import My_Vector

class Test_Vector(unittest.TestCase):

    def __set_both(self, v:list):
        self.iv.value = v
        self.mv.value = v

    def __clean(self):
        self.iv = My_Vector()
        self.mv = My_Vector()

    def test_add_scalar(self):
        self.__clean()

        self.mv.value = [10,10,10]
        self.iv.add_scalar(10)
        self.assertTrue(self.iv == self.mv, "Should add 2 default vectors")

        self.iv.add_scalar(-10)
        self.assertTrue(self.iv == self.mv, "Should be true, as the array is not modified due to the negative value")

        self.iv.add_scalar(2)
        self.assertFalse(self.iv == self.mv, "Should be false, as the arrays are not the same")

    def test_add(self):
        self.__clean()

        self.__set_both([1, 2, 3, 4])
        self.iv.add([1,2,3])
        self.assertEqual(self.iv, self.mv, "Should not change vector as it has different lengths")

        self.iv.value = [1,1]
        self.mv.value = [2,2]
        self.iv.add([1,1])
        self.assertEqual(self.iv, self.mv, "Should change accordingly")


    def test_subtract(self):
        self.__clean()

        self.__set_both([1, 2])
        self.iv.subtract([1])
        self.assertEqual(self.iv, self.mv, "Should not change vector as it has different lengths")

        self.__set_both([1, 2])
        self.iv.subtract([1,1])
        self.assertNotEqual(self.iv, self.mv, "Should change accordingly")

    def test_multiply(self):
        self.__clean()

        self.__set_both([1, 2])
        self.iv.multiplication([1])
        self.assertEqual(self.iv, self.mv, "Should not change vector as it has different lengths")

        self.__set_both([1, 2])
        self.iv.multiplication([2, 4])
        self.assertNotEqual(self.iv, self.mv, "Should change accordingly")

    def test_sum(self):
        self.__clean()

        self.assertEqual(self.iv.sum(), 0, "Should compute the sum being 0")

        self.iv.value = [1,2,3]
        self.assertEqual(self.iv.sum(), 6, "Should compute correctly the sum")

        self.iv.value = [1,-1]
        self.assertEqual(self.iv.sum(), 0, "Should compute the sum of opposite numbers")

    def test_product(self):
        self.__clean()

        self.assertEqual(self.iv.sum(), 0, "Should compute the product being 0")

        self.iv.value = [1,1,1]
        self.assertEqual(self.iv.product(), 1, "Should get product of an equal vector")

        self.iv.value = [2,1,3]
        self.assertEqual(self.iv.product(), 6, "Should compute correctly the product")

    def test_avg(self):
        self.__clean()

        self.assertEqual(self.iv.avg(), 0, "Should compute the avg of 0 vector")

        self.iv.value = [1,1]
        self.assertEqual(self.iv.avg(), 1, "Should compute the avg of an equal vector")

        self.iv.value = [-4,4]
        self.assertEqual(self.iv.avg(), 0, "Should compute the avg of opposite numbers")

    def test_min(self):
        self.__clean()

        self.assertEqual(self.iv.min(), 0, "Should get the minimum out of the zero vector")

        self.iv.value = [-1,0,1]
        self.assertEqual(self.iv.min(), -1, "Should get the bigger negative value in this case") # Why am I writing test messages in such way? maybe cuz im tired or smt, i don't think someone will read this ever, if so, please let me now

        self.iv.value = [1,1,5]
        self.assertEqual(self.iv.min(), 1, "Should get the min value correctly")

    def test_max(self):
        self.__clean()

        self.assertEqual(self.iv.max(), 0, "Should get the maximum value out of the zero vector")

        self.iv.value = [1,2,3]
        self.assertEqual(self.iv.max(), 3, "Should get the correct max value")

        self.iv.value = [1,2,2]
        self.assertEqual(self.iv.max(), 2, "Should get max out of multiple max numbers") # Like I test how dumb other peoples code is, I mean this function basically test numpy, so irelevant, but ok


if __name__ == '__main__':
    unittest.main()
