from infrastructure.measurement_repository import Measurement_Repository
from domain.measurement import Measurement

import unittest
class Test_Measurement(unittest.TestCase):
    def test_add_measurements(self):
        self.__repo = Measurement_Repository([
            Measurement(3.3, 55, 10),
            Measurement(4.0, 30, 11),
            Measurement(2.5, 90, 9),
            Measurement(7.7, 20, 10),
            Measurement(8.9, 60, 11)
        ])
        self.assertRaises(Exception, self.__repo.add_measurement, Measurement(-1.0,-1,-1))
