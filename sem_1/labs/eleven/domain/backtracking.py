from copy import deepcopy
from typing import Any, List

class Backtracking:
    @staticmethod
    def backtrack(k:int, data:List[Any], same = None):
        if k <= 1:
            raise ValueError("k must be greater than 1")
        if same is None:
            same = lambda x:x
        if data is None:
            raise ValueError("data must be not None")

        data = deepcopy(data)
        final = []
        group = []
        for i in range(len(data)):
            for j in range(i, len(data)):
                group.append(data[j])
                if len(group) <= k:
                    continue
                if len(group) == k and same(*group):
                    final.append(group)
                    group = []

        return final

    @staticmethod
    def init():
        return 0

    @staticmethod
    def getNext(sol, pos):
        return sol[pos] + 1

    # @staticmethod
    # def isConsistent(sol):
    #     isCons = True
    #     i = 0
    #     while (i < len(sol) - 1) and isCons:
    #         if (sol[i] == sol)

