import unittest
from domain.plane import Plane
from domain.passenger import Passenger
import fakedata

class Test_Plane(unittest.TestCase):
    def setUp(self):
        self.passengers = fakedata.generate_passenger(10) or []
        if not self.passengers:
            raise Exception("Generated Passengers are empty")

        self.plane = Plane("plane1", "123", "Hencry", 2, "Miami")

    def test_add_passenger(self):
        self.setUp()
        self.plane.add_passenger(self.passengers[0])
        self.assertEqual(self.plane.passengers, [self.passengers[0]])
        self.assertEqual(self.plane.no_of_passengers, 1)

        self.assertRaises(Exception, self.plane.add_passenger, self.passengers[0])
        self.assertEqual(self.plane.no_of_passengers, 1)

        self.plane.add_passenger(self.passengers[1])
        self.assertEqual(self.plane.no_of_passengers, 2)
        self.assertRaises(Exception, self.plane.add_passenger, self.passengers[2])
        self.assertEqual(self.plane.no_of_passengers, 2)

    def test_remove_passenger(self):
        self.plane.add_passenger(self.passengers[0])
        self.plane.add_passenger(self.passengers[1])
        self.assertRaises(Exception, self.plane.remove_passenger, self.passengers[2])

        self.plane.remove_passenger(self.passengers[1])
        self.assertEqual(self.plane.no_of_passengers, 1)

        self.plane.remove_passenger(self.passengers[0])
        self.assertEqual(self.plane.no_of_passengers, 0)

    def test_sort_by_last_name(self):
        self.plane = Plane("plane1", "123", "Hencry", 4, "Miami", [
            Passenger("Mihai", "Popescu", "123"),
            Passenger("Andrei", "Maricica", "123"),
            Passenger("Grigore", "Andreea", "123"),
        ])
        splanes = self.plane.sort_by_last_name()
        self.assertEqual(splanes[0].last_name, "Andreea")
        self.assertEqual(splanes[2].last_name, "Popescu")
        self.assertEqual(len(splanes), 3)

        self.plane.add_passenger(Passenger("Elon", "Aaron", "123"))
        splanes = self.plane.sort_by_last_name()
        self.assertEqual(splanes[0].last_name, "Aaron")
        self.assertEqual(len(splanes), 4)

    def test_get_passengers_which_containts_string(self):
        self.plane = Plane("plane1", "123", "Hencry", 4, "Miami", [
            Passenger("Mihai", "Popescu", "123"),
            Passenger("Andrei", "Maricica", "123"),
            Passenger("Grigore", "Andreea", "123"),
            Passenger("Elon", "Aaron", "123")
        ])
        ap = self.plane.get_passengers_which_contains("a")
        self.assertEqual(len(ap), 4)
        mp = self.plane.get_passengers_which_contains("M")
        self.assertEqual(len(mp), 2)
        zp = self.plane.get_passengers_which_contains("z")
        self.assertEqual(len(zp), 0)
