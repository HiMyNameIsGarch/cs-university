from domain.heap import Heap

class Sorting(Heap):
    # The main function to sort an array of given size
    @staticmethod
    def sort(data, method = None):
        if method is None:
            method = lambda x: x

        sorted_data = Heap.heap_sort(data, method)
        return sorted_data

    @staticmethod
    def filter(data,  lambda_function = None):
        if lambda_function == None:
            lambda_function = lambda x: x
        return [e for e in data if lambda_function(e)]

