import unittest
from domain.heap import Heap
from domain.sorting import Sorting

class Test_Heap(unittest.TestCase):
    def test_sorting_with_heap(self):
        lst = [4, 10, 3, 5, 1]
        srted = Heap.heap_sort(lst)
        self.assertListEqual(srted, sorted(lst))
        lst = [1, 2, 3, 4, 5]
        srted = Heap.heap_sort(lst)
        self.assertListEqual(srted, sorted(lst))
        lst = [9, 8, 7, 6, 5]
        srted = Heap.heap_sort(lst)
        self.assertListEqual(srted, sorted(lst))

    def test_filtering(self):
        list = [ 1, 1, 2,2,2, 3, 4, 5, 6, 7, 8, 9, 10]
        filtered = Sorting.filter(list, lambda x: x % 2 == 0)
        self.assertListEqual(filtered, [2,2,2,4,6,8,10])
        list = [10, 20, 12, 34, 56, 67]
        filtered = Sorting.filter(list, lambda x: x % 10 == 0)
        self.assertListEqual(filtered, [10, 20])
        list = [5, 10, 15, 123, 435, 56]
        filtered = Sorting.filter(list, lambda x: x % 5 == 0)
        self.assertListEqual(filtered, [5, 10, 15, 435])

