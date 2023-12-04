from domain.my_vector import My_Vector
import matplotlib.pyplot as plt
from domain.color import Color
from domain import utils

class Vector_Repository:
    def __init__(self) -> None:
        mv = My_Vector(1, Color('r'))
        mv.set_value([1,2,3])
        my = My_Vector(2, Color('y'))
        my.set_value([2,2,3])
        mz = My_Vector(3, Color('b'))
        mz.set_value([4,2,3])
        self.__vectors:list[My_Vector] = [mv, my, mz]

    def add(self, v:My_Vector) -> None:
        for lv in self.__vectors:
            if lv.get_name_id() == v.get_name_id():
                return None
        self.__vectors.append(v)

    def get_all(self) -> list[My_Vector]:
        return self.__vectors

    def get_at_idx(self, idx:int) -> My_Vector:
        if not utils.is_index_valid(self.__vectors, idx):
            return My_Vector()
        return self.__vectors[idx]

    def update_at_idx(self, idx:int, nv:My_Vector) -> None:
        if not utils.is_index_valid(self.__vectors, idx):
            return None
        self.__vectors[idx] = nv

    def update_by_name_id(self, name_id:str, nv:My_Vector) -> None:
        for i in range(len(self.__vectors)):
            if self.__vectors[i].get_name_id() == name_id:
                self.__vectors[i] = nv
                return

    def del_by_idx(self, idx:int) -> None:
        if not utils.is_index_valid(self.__vectors, idx):
            return None
        del self.__vectors[idx]

    def del_by_name_id(self, name_id:str) -> None:
        for i in range(len(self.__vectors)):
            if self.__vectors[i].get_name_id() == name_id:
                del self.__vectors[i]
                return

    def plot(self) -> None:
        for vector in self.__vectors:
            plt.plot(vector.get_value(), f"{vector.get_color().value}{vector.get_type_plot()}")
        plt.show()

    def get_sum_all_vectors(self) -> int:
        s = 0
        for v in self.__vectors:
            s += v.sum()
        return s

    def delete_all_vectors(self) -> None:
        self.__vectors = []

    def update_vectors_by_scalar(self, scalar:int) -> None:
        for v in self.__vectors:
            v.add_scalar(scalar)
