from infrastructure.vector_repository import Vector_Repository
from domain.my_vector import My_Vector
from functools import partial
from domain.color import Color
from domain.utils import *

class UI:
    def __own_partial(self, func, func_arg):
        if callable(func_arg) and callable(func):
            func(func_arg())

    def __partial_nested(self, func, func2, func_arg):
        func(func2(func_arg()))

    def __partial_two_args(self, bigf, smf1, smf2):
        bigf(smf1(), smf2())


    def __print_lst(self, lst:list[My_Vector]):
        for i in range(len(lst)):
            print(str(i + 1) + ". <", str(lst[i]) + " >")

    def __init__(self) -> None:
        self.__repo = Vector_Repository()
        self.__opts = {
            "1" : ("Add a vector to the repository",
                   partial(self.__own_partial,
                           self.__repo.add,
                           self.__get_vector_from_user)),
            "2" : ("Get all vectors",
                   partial(self.__own_partial,
                           self.__print_lst,
                           self.__repo.get_all)),
            "3" : ("Get a vector at a given index",
                   partial(self.__partial_nested,
                           print,
                           self.__repo.get_at_idx,
                           self.__get_idx_from_user)),
            "4" : ("Update a vector at a given index",
                   partial(self.__partial_two_args,
                           self.__repo.update_at_idx,
                           self.__get_idx_from_user,
                           self.__get_vector_from_user)),
            "5" : ("Update a vector identified by name_id",
                   partial(self.__partial_two_args,
                           self.__repo.update_by_name_id,
                           self.__get_vector_from_user,
                           self.__get_idx_from_user)),
            "6" : ("Delete a vector by index",
                   partial(self.__own_partial,
                           self.__repo.del_by_idx,
                           self.__get_idx_from_user)),
            "7" : ("Delete a vector by name_id",
                   partial(self.__own_partial,
                           self.__repo.del_by_name_id,
                           self.__get_name_id_from_user)),
            "8" : ("Plot all vectors",
                   self.__repo.plot),
            "9" : ("Get the sum of elements in all vectors",
                   partial(self.__own_partial, print,
                           self.__repo.get_sum_all_vectors)),
            "17" : ("Delete all vectors from repository",
                    self.__repo.delete_all_vectors),
            "21" : ("Update all vectors by adding a given scalar to each element",
                    partial(self.__own_partial,
                            self.__repo.update_vectors_by_scalar,
                            self.__get_scalar)),
        }

    def __get_scalar(self):
        return intput("Scalar: ")

    def __get_vector_from_user(self) -> My_Vector:
        mv = My_Vector()
        txt = input("Write vector in form: 1,2,3: ")
        vector_list = []
        for e in txt.split(","):
            try:
                vector_list.append(int(e))
            except ValueError:
                pass
        mv.set_value(vector_list)
        t = intput("Vector of type: ")
        mv.set_type(t)
        name = input("Vector name id: ")
        mv.set_name_id(name)
        color = input("Vector color(r,g,b,y,m): ")
        mv.set_color(Color(color))
        return mv

    def __get_name_id_from_user(self) -> str:
        return input("Name id: ")

    def __get_idx_from_user(self) -> int:
        idx = -1
        while True:
            try:
                idx = intput("Index: ")
            except ValueError as ve:
                print(ve)
                raise ValueError(ve)
            break
        return idx

    def __menu(self):
        print('\033c', end='')
        for key in self.__opts:
            print(key + ".", self.__opts[key][0])

    def start(self):
        while True:
            try:
                self.__menu()
                key = input("Pick your poison: ")
                if key == "-1":
                    return
                self.__opts[key][1]()
                input("")
            except Exception as e:
                input(e)
