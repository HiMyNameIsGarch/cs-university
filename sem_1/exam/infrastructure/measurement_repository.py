from typing import List
from domain.measurement import Measurement


class Measurement_Repository:
    def __init__(self, measurements:List[Measurement] = []):
        self.__measurements = measurements

    @property
    def measurements(self) -> List[Measurement]:
        return self.__measurements

    def add_measurement(self, new_measurement:Measurement):
        """
        Purpose: Add a new measurement and verify all the conditions
        """
        if new_measurement.pressure <=0 or new_measurement.pressure >=10:
            raise ValueError("Pressure invalid")
        if new_measurement.hour_of_day <=0 or new_measurement.hour_of_day >=23:
            raise ValueError("Hour of day invalid")
        if new_measurement.temperature <=0 or new_measurement.temperature >=100:
            raise ValueError("Temperature invalid")

        self.measurements.append(new_measurement)

    def display_pressure_higher(self, pressure_value:float):
        """
        Purpose: Displays all the measurements higher than a given pressure
        """
        method = lambda e: e.pressure >= pressure_value
        new_pressure = [e for e in self.measurements if method(e)]
        return new_pressure

    def display_avg_pressure_for(self, hour_of_day:int):
        """
        Purpose: Displays the average pressure and temperature for that hour of the day
        """
        method = lambda e: e.hour_of_day == hour_of_day
        lst = [e for e in self.measurements if method(e)]
        avg_pressure  = 0
        avg_temp = 0
        for m in lst:
            avg_pressure += m.pressure
            avg_temp += m.temperature
        return (avg_pressure / len(lst), avg_temp / len(lst))

