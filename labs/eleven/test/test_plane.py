import unittest
from domain.plane import Plane
from labs.eleven.domain.passenger import Passenger
import fakedata

class Test_Plane(unittest.TestCase):
    def setUp(self):
        self.passengers = fakedata.generate_passenger(10) or []
        if not self.passengers:
            raise Exception("Generated Passengers are empty")

        self.plane = fakedata.generate_planes(1, 0, 0)[0] or Plane("plane1", "123", "Hencry", 12, "Miami")

    def test_add_passenger(self):
        self.plane.add_passenger(self.passengers[0])
        self.assertEqual(self.plane.passengers, [self.passengers[0]])

    def test_remove_passenger(self):
        self.plane.add_passenger(self.passengers[0])
        self.assertEqual(self.plane.passengers, [self.passengers[0]])

    def test_sort_by_last_name(self):
        pass

    def test_get_passengers_which_containts_string(self):
        pass
