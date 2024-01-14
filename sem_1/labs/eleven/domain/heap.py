class Heap:
    @staticmethod
    def heapify(arr, n, i, method = None):
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
            # self.__heapify(arr, n, largest) # Fucking bug
            Heap.heapify(arr, n, largest, method)

    @staticmethod
    def heap_sort(arr, method = None):
        if method is None:
            method = lambda x: x

        n = len(arr)
         # Build a maxheap.
         # Since last parent will be at ((n//2)-1) we can start at that location.

        for i in range(n // 2 - 1, -1, -1):
            Heap.heapify(arr, n, i, method)

         # One by one extract elements

        for i in range(n - 1, 0, -1):
            (arr[i], arr[0]) = (arr[0], arr[i])  # swap
            Heap.heapify(arr, i, 0, method)

        return arr
