from domain.my_vector import My_Vector
import matplotlib.pyplot as plt
from domain import utils
from domain.color import Color

class Vector_Repository:
    def __init__(self) -> None:
        mv = My_Vector(1, Color('r'))
        mv.value = [1,2,3]
        my = My_Vector(2, Color('y'))
        my.value = [2,2,3]
        mz = My_Vector(3, Color('b'))
        mz.value = [4,2,3]
        self.__vectors:list[My_Vector] = [mv, my, mz]

    """
    Add a My_Vector instance to the collection if its name_id is unique.

    Parameters:
    - v: A My_Vector instance to be added.

    Returns:
    - None
    """
    def add(self, v:My_Vector) -> None:
        for lv in self.__vectors:
            if lv.name_id == v.name_id and lv.color != v.color:
                return None
        self.__vectors.append(v)

    """
    Get all My_Vector instances in the collection.

    Returns:
    - list[My_Vector]: List of all My_Vector instances.
    """
    def get_all(self) -> list[My_Vector]:
        return self.__vectors

    """
    Get the My_Vector instance at the specified index.

    Parameters:
    - idx: Index of the desired My_Vector instance.

    Returns:
    - My_Vector: The My_Vector instance at the specified index or an empty My_Vector if the index is invalid.
    """
    def get_at_idx(self, idx:int) -> My_Vector:
        if not utils.is_index_valid(self.__vectors, idx):
            return My_Vector()
        return self.__vectors[idx]

    """
    Update the My_Vector instance at the specified index.

    Parameters:
    - idx: Index of the My_Vector instance to be updated.
    - nv: The new My_Vector instance.

    Returns:
    - None
    """
    def update_at_idx(self, idx:int, nv:My_Vector) -> None:
        if not utils.is_index_valid(self.__vectors, idx):
            return None
        self.__vectors[idx] = nv

    """
    Update the My_Vector instance with the specified name_id.

    Parameters:
    - name_id: Name_id of the My_Vector instance to be updated.
    - nv: The new My_Vector instance.

    Returns:
    - None
    """
    def update_by_name_id(self, name_id:str, nv:My_Vector) -> None:
        for i in range(len(self.__vectors)):
            if self.__vectors[i].name_id == name_id:
                self.__vectors[i] = nv
                return

    """
    Delete the My_Vector instance at the specified index.

    Parameters:
    - idx: Index of the My_Vector instance to be deleted.

    Returns:
    - None
    """
    def del_by_idx(self, idx:int) -> None:
        if not utils.is_index_valid(self.__vectors, idx-1):
            return None
        del self.__vectors[idx]

    """
    Delete the My_Vector instance with the specified name_id.

    Parameters:
    - name_id: Name_id of the My_Vector instance to be deleted.

    Returns:
    - None
    """
    def del_by_name_id(self, name_id:str) -> None:
        for i in range(len(self.__vectors)):
            if self.__vectors[i].name_id == name_id:
                del self.__vectors[i]
                return

    """
    Plot all My_Vector instances in the collection.

    Returns:
    - None
    """
    def plot(self) -> None:
        for vector in self.__vectors:
            plt.plot(vector.value, f"{vector.color.value}{vector.type_color}")
        plt.show()

    """
    Calculate the sum of all vectors in the collection.

    Returns:
    - int: The sum of all vector elements.
    """
    def get_sum_all_vectors(self) -> int:
        s = 0
        for v in self.__vectors:
            s += v.sum()
        return s

    """
    Delete all My_Vector instances from the collection.

    Returns:
    - None
    """
    def delete_all_vectors(self) -> None:
        self.__vectors = []

    """
    Update all vectors in the collection by adding a scalar value.

    Parameters:
    - scalar: An integer value to be added to all vectors.

    Returns:
    - None
    """
    def update_vectors_by_scalar(self, scalar:int) -> None:
        for v in self.__vectors:
            v.add_scalar(scalar)
