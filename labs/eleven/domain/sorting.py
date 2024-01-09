from domain.heap import Heap
from copy import deepcopy

class Sorting(Heap):
    # The main function to sort an array of given size
    # Parameters: data:List[any] the data to be sorted
    #             method:Function the method to be used for sorting
    # Return: List[any] the sorted data
    # Exceptions: ValueError if data is None
    @staticmethod
    def sort(data, method = None):
        if data == None:
            raise ValueError("data must be not None")
        data = deepcopy(data)
        if method is None:
            method = lambda x: x

        sorted_data = Heap.heap_sort(data, method)
        return sorted_data

    # Filter a list of data
    # Parameters: data:List[any] the data to be filtered
    #             lambda_function:Function the function to be used for filtering
    # Return: List[any] the filtered data
    # Exceptions: ValueError if data is None
    @staticmethod
    def filter(data, lambda_function = None):
        if lambda_function == None:
            lambda_function = lambda x: x
        if data == None:
            raise ValueError("data must be not None")
        data = deepcopy(data)

        return [e for e in data if lambda_function(e)]

    @staticmethod
    def groups_of(k:int, data, same = None):
        if k <= 0:
            raise ValueError("k must be greater than 0")
        if data == None:
            raise ValueError("data must be not None")
        data = deepcopy(data)

        if same == None:
            same = lambda x: x

        it = iter(data)
        sorted = [e for e in data if same(e, next(it))]
        return [sorted[i:i + k] for i in range(0, len(sorted), k)]
