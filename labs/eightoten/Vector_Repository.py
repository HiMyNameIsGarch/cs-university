from My_Vector import My_Vector
import numpy as np
import matplotlib.pyplot as plt

class Vector_Repository:
    def __init__(self) -> None:
        mv = My_Vector(1)
        mv.set_value([1,2,3])
        my = My_Vector(1)
        my.set_value([2,2,3])
        mz = My_Vector(1)
        mz.set_value([4,2,3])
        self.__vectors:list[My_Vector] = [mv, my, mz]

    def add(self, v:My_Vector) -> None:
        self.__vectors.append(v)

    def get_all(self) -> list[My_Vector]:
        return self.__vectors

    def get_at_idx(self, idx:int) -> My_Vector:
        return self.__vectors[idx]

    def update_at_idx(self, idx:int, nv:My_Vector) -> None:
        self.__vectors[idx] = nv

    def update_by_id(self, id:str, nv:My_Vector) -> None:
        for i in range(len(self.__vectors)):
            if self.__vectors[i].get_name_id() == id:
                self.__vectors[i] = nv
                return

    def del_by_idx(self, idx:int) -> None:
        del self.__vectors[idx]

    def del_by_id(self, name_id:str) -> None:
        for i in range(len(self.__vectors)):
            if self.__vectors[i].get_name_id() == name_id:
                del self.__vectors[i]
                return

    def plot(self) -> None:
        V = np.array([[1,1], [-2,2], [4,-7]])
        origin = np.array([[0, 0, 0],[0, 0, 0]]) # origin point

        plt.quiver(*origin, V[:,0], V[:,1], color=['r','b','g'], scale=21)
        plt.show()
