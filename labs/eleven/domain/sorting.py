class Sorting:
    def __heapify(self, arr, n, i, method = None):
        if method is None:
            method = lambda x: x

        largest = i  # Initialize largest as root
        l = 2 * i + 1  # left = 2*i + 1
        r = 2 * i + 2  # right = 2*i + 2

        # See if left child of root exists and is
        # greater than root
        if l < n and method(arr[i]) < method(arr[l]):
            largest = l

        # See if right child of root exists and is
        # greater than root
        if r < n and method(arr[largest]) < method(arr[r]):
            largest = r

        # Change root, if needed
        if largest != i:
            (arr[i], arr[largest]) = (arr[largest], arr[i])  # swap

            # Heapify the root.

            self.__heapify(arr, n, largest)

    def __heapSort(self, arr, method = None):
        n = len(arr)
         # Build a maxheap.
         # Since last parent will be at ((n//2)-1) we can start at that location.

        for i in range(n // 2 - 1, -1, -1):
            self.__heapify(arr, n, i, method)

         # One by one extract elements

        for i in range(n - 1, 0, -1):
            (arr[i], arr[0]) = (arr[0], arr[i])  # swap
            self.__heapify(arr, i, 0, method)

        return arr


    # The main function to sort an array of given size

    # TODO: implement a way to sort by a given function
    def sort(self, data, method = None):
        if method is None:
            method = lambda x: x

        self.sorted_data = self.__heapSort(data, method)
        return self.sorted_data

    def filter(self, data,  lambda_function = None):
        if lambda_function == None:
            lambda_function = lambda x: x
        return [e for e in data if lambda_function(e)]

