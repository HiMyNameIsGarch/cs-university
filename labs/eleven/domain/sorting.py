from domain.heap import Heap

class Sorting(Heap):
    # The main function to sort an array of given size
    @staticmethod
    def sort(data, method = None):
        if data == None:
            raise ValueError("data must be not None")
        if method is None:
            method = lambda x: x

        sorted_data = Heap.heap_sort(data, method)
        return sorted_data

    @staticmethod
    def filter(data,  lambda_function = None):
        if lambda_function == None:
            lambda_function = lambda x: x
        if data == None:
            raise ValueError("data must be not None")

        return [e for e in data if lambda_function(e)]

    @staticmethod
    def groups_of(k:int, data, same = None):
        if k <= 0:
            raise ValueError("k must be greater than 0")
        if data == None:
            raise ValueError("data must be not None")

        if same == None:
            same = lambda x: x

        it = iter(data)
        sorted = [e for e in data if same(e, next(it))]
        return [sorted[i:i + k] for i in range(0, len(sorted), k)]
