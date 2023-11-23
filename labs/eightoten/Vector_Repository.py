from labs.eightoten.My_Vector import My_Vector
# import matplotlib.pyplot as plt

class Vector_Repository:
    def __init__(self) -> None:
        self.__vectors:list[My_Vector] = []

    def add(self, v:My_Vector):
        self.__vectors.append(v)

    def get_all(self):
        return self.__vectors

    def get_at_idx(self, idx):
        return self.__vectors[idx]

    def update_at_idx(self, idx, nv:My_Vector):
        self.__vectors[idx] = nv

    def update_by_id(self, id, nv:My_Vector):
        for i in range(len(self.__vectors)):
            if self.__vectors[i].get_name_id() == id:
                self.__vectors[i] = nv
                break

    def del_by_idx(self, idx):
        del self.__vectors[idx]

    def del_by_id(self, id):
        for i in range(len(self.__vectors)):
            if self.__vectors[i].get_name_id() == id:
                del self.__vectors[i]
                break

    def plot(self):
        for _ in self.__vectors:
            pass
            # plt.scatter(e.get_coord_x(), e.get_coord_y())


