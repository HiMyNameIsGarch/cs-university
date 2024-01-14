import unittest

from infrastructure.vector_repository import Vector_Repository
from domain.my_vector import My_Vector

class Test_Vector_Repo(unittest.TestCase):
    def __cleanup(self):
        self.__repo = Vector_Repository()

    def test_add(self):
        self.__cleanup()
        # base case
        fv = My_Vector()
        fv.value = [1,1,1]
        fv.name_id = "id"
        fv.value= [1]
        nv = My_Vector()
        nv.value = [1,1,1]
        nv.name_id = "id2"
        nv.value= [1]
        self.__repo.add(fv)
        self.__repo.add(nv)
        self.assertEqual(len(self.__repo.get_all()), 2)
        l = [fv, nv]
        for i,v in enumerate(self.__repo.get_all()):
            self.assertEqual(v, l[i])

        # same name_id
        self.assertIsNone(self.__repo.add(fv))

        self.assertEqual(len(self.__repo.get_all()), 3)
        l = [fv, nv]
        for i,v in enumerate(self.__repo.get_all()):
            self.assertEqual(v, l[i-1])

    def test_get_at_idx(self):
        self.__cleanup()
        # base case
        fv = My_Vector()
        fv.value = [1,1,1]
        fv.name_id = "id"
        fv.value= [1]
        self.__repo.add(fv)

        self.assertEqual(self.__repo.get_at_idx(-1), My_Vector())
        self.assertEqual(self.__repo.get_at_idx(0), fv)
        self.assertEqual(self.__repo.get_at_idx(5), My_Vector())

    def test_update_at_idx(self):
        self.__cleanup()

        fv = My_Vector()
        fv.value = [1,1,1]
        fv.name_id = "id"
        fv.value= [1]
        self.__repo.add(fv)

        iv = My_Vector()
        iv.value = [1,1,1]
        iv.name_id = "id2"
        iv.value= [1]
        self.__repo.add(iv)

        self.assertIsNone(self.__repo.update_at_idx(1, iv))
        for v in self.__repo.get_all():
            self.assertEqual(v, iv)

        self.assertIsNone(self.__repo.update_at_idx(-1, fv))

    def test_update_by_name_id(self):
        self.__cleanup()
        fv = My_Vector()
        fv.value = [1,1,1]
        fv.name_id = "id"
        fv.value= [1]
        self.__repo.add(fv)

        nv = My_Vector()
        nv.value = [1,1,1]
        nv.name_id = "id2"
        nv.value= [1]

        self.assertIsNone(self.__repo.update_by_name_id("id", fv))
        self.assertTrue(self.__repo.get_all()[0] == fv)

        self.assertIsNone(self.__repo.update_by_name_id("asdasd", fv))


    def test_del_by_idx(self):
        self.__cleanup()

        fv = My_Vector()
        fv.value = [1,1,1]
        fv.name_id = "id"
        fv.value= [1]
        self.__repo.add(fv)

        iv = My_Vector()
        iv.value = [1,1,1]
        iv.name_id = "id2"
        iv.value= [1]
        self.__repo.add(iv)

        self.assertIsNone(self.__repo.update_at_idx(1, iv))
        for v in self.__repo.get_all():
            self.assertEqual(v, iv)

        self.assertIsNone(self.__repo.del_by_idx(-1))

    def test_del_by_name_id(self):
        self.__cleanup()
        fv = My_Vector()
        fv.value = [1,1,1]
        fv.name_id = "id"
        fv.value= [1]
        self.__repo.add(fv)

        self.assertIsNone(self.__repo.del_by_name_id("id"))
        self.assertTrue(len(self.__repo.get_all()) == 0)

        self.assertIsNone(self.__repo.del_by_idx(-1))

    # Optional???
    def test_get_sum_vectors(self):
        self.__cleanup()
        fv = My_Vector()
        fv.value = [1,1,1]
        fv.name_id = "id"
        fv.value= [1]
        self.__repo.add(fv)

        self.assertEqual(self.__repo.get_sum_all_vectors(), 1)

        nv = My_Vector()
        nv.value = [1,1,1]
        nv.name_id = "id2"
        nv.value= [1]
        self.__repo.add(nv)

        self.assertEqual(self.__repo.get_sum_all_vectors(), 2)

        rv = My_Vector()
        rv.value = [1,1,1]
        rv.name_id = "id3"
        rv.value= [1]
        self.__repo.add(nv)

        self.assertEqual(self.__repo.get_sum_all_vectors(), 3)

    def test_del_all_vectors(self):
        self.__cleanup()
        self.assertEqual(self.__repo.delete_all_vectors(), None)
        self.assertEqual(self.__repo.get_all(), [])

        rv = My_Vector()
        rv.value = [1,1,1]
        rv.name_id = "id3"
        rv.value= [1]
        self.__repo.add(rv)
        self.assertEqual(self.__repo.delete_all_vectors(), None)
        self.assertEqual(self.__repo.get_all(), [])

    def test_update_vectors_scalar(self):
        self.__cleanup()
        rv = My_Vector()
        rv.value = [1,1,1]
        rv.name_id = "id3"
        rv.value= [1]
        self.__repo.add(rv)
        self.assertIsNone(self.__repo.update_vectors_by_scalar(2))
        self.assertEqual(self.__repo.get_sum_all_vectors(), 3)

        self.assertIsNone(self.__repo.update_vectors_by_scalar(0))
        self.assertEqual(self.__repo.get_sum_all_vectors(), 3)

        self.assertIsNone(self.__repo.update_vectors_by_scalar(-2))
        self.assertEqual(self.__repo.get_sum_all_vectors(), 3)

if __name__ == '__main__':
    unittest.main()
