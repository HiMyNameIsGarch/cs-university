import unittest
from infrastructure.airport_repository import Airport_Repository
from domain.plane import Plane
import fakedata
from domain.passenger import Passenger

class Test_Airport_Repository(unittest.TestCase):
    @property
    def planes(self):
        return [
            Plane("Private", "123", "Hencry", 50, "Miami",[
                Passenger("Mihai", "Popescu", "123"),
                Passenger("Cioaca", "Andronache", "123"),
            ]),
            Plane("Luxury", "124", "Mani", 20, "Miami",[
                Passenger("Hagi", "Giga", "123"),
                Passenger("Mihai", "Regele", "123"),
            ]),
            Plane("Cheap", "125", "Nency", 15, "Miami",[
                Passenger("Andreea", "Popescu", "123"),
                Passenger("Cioara", "Radu", "123"),
            ])
        ]

    def test_add_plane(self):
        self.repo = Airport_Repository()
        self.repo.add_plane(fakedata.generate_planes(1,0,0)[0])
        self.assertEqual(self.repo.no_of_planes, 1)

        self.assertRaises(Exception, self.repo.add_plane, self.repo.planes[0])
        self.assertEqual(self.repo.no_of_planes, 1)

        self.repo.add_plane(fakedata.generate_planes(1,0,0)[0])
        self.assertEqual(self.repo.no_of_planes, 2)

    def test_remove_plane(self):
        self.repo = Airport_Repository()
        planes = fakedata.generate_planes(3,0,0)
        self.repo.add_plane(planes[0])
        self.repo.add_plane(planes[1])

        self.assertRaises(Exception, self.repo.remove_plane, planes[2])
        self.assertEqual(self.repo.no_of_planes, 2)

        self.repo.remove_plane(planes[1])
        self.assertEqual(self.repo.no_of_planes, 1)

        self.repo.remove_plane(planes[0])
        self.assertEqual(self.repo.no_of_planes, 0)

        self.assertRaises(Exception, self.repo.remove_plane, planes[0])
        self.assertEqual(self.repo.no_of_planes, 0)

    def test_sort_by_num_of_passengers(self):
        planes = [
            Plane("plane3", "125", "Nency", 15, "Miami", fakedata.generate_passenger(15)),
            Plane("plane1", "123", "Hencry", 50, "Miami", fakedata.generate_passenger(50)),
            Plane("plane2", "124", "Mani", 20, "Miami", fakedata.generate_passenger(20)),
        ]
        self.repo = Airport_Repository(planes)

        sorted = self.repo.sort_by_number_of_passengers()
        self.assertEqual(sorted[0].id, planes[0].id)
        self.assertEqual(sorted[2].id, planes[1].id)
        self.assertEqual(self.repo.no_of_planes, 3)

        pplane = Plane("plane4", "127", "Rency", 5, "Miami", fakedata.generate_passenger(5))
        self.repo.add_plane(pplane)

        sorted = self.repo.sort_by_number_of_passengers()
        self.assertEqual(sorted[0].id, pplane.id)
        self.assertEqual(self.repo.no_of_planes, 4)


    def test_sort_by_no_of_passengers_and_name_starting_with(self):
        # The test should be like the one from above
        self.repo = Airport_Repository(self.planes)

        sorted = self.repo.sort_by_no_of_passengers_and_name_starting_with("M")
        self.assertEqual(sorted[0].name, self.planes[1].name)
        self.assertEqual(len(sorted), 2)
        self.assertEqual(self.repo.no_of_planes, 3)

        sorted = self.repo.sort_by_no_of_passengers_and_name_starting_with("Z")
        self.assertEqual(len(sorted), 0)

    def test_sort_by_concat_nums_of_passengers_and_destination(self):
        planes = [
            Plane("plane3", "125", "Nency", 15, "Miami", fakedata.generate_passenger(15)),
            Plane("plane3", "125", "Nency", 15, "Mamonia", fakedata.generate_passenger(15)),
            Plane("plane1", "123", "Hencry", 50, "Miami", fakedata.generate_passenger(50)),
            Plane("plane2", "124", "Mani", 20, "Miami", fakedata.generate_passenger(20)),
        ]
        self.repo = Airport_Repository(planes)
        sorted = self.repo.sort_by_concat_nums_of_passengers_and_destination()
        self.assertEqual(sorted[0], planes[1])
        self.assertEqual(len(sorted), 4)
        self.assertEqual(sorted[3], planes[2])

    def test_get_planes_starting_with_the_same_3_letters(self):
        self.repo = Airport_Repository(self.planes)

        filtered = self.repo.get_planes_starting_with_the_same_3_letters()
        self.assertEqual(len(filtered), 3)

        self.assertEqual(filtered[0].name, self.planes[0].name)

    def test_get_planes_where_is_the_passenger_named(self):
        self.repo = Airport_Repository(self.planes)

        filtered = self.repo.get_planes_where_is_the_passenger_named("Mihai Popescu")
        self.assertEqual(filtered[0].name, self.planes[0].name)

        filtered = self.repo.get_planes_where_is_the_passenger_named("No Name")
        self.assertEqual(len(filtered), 0)

    # TODO
    def test_form_groups_of_planes_same_dest_diff_companies(self):
        pass
    def test_form_groups_of_passengers_same_plane_diff_last_name(self):
        pass




