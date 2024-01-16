from infrastructure.measurement_repository import Measurement_Repository
from domain.measurement import Measurement
from domain.utils import intput
class UI:
    def add(self):
        self.__repo.add_measurement(Measurement(
            intput("Pressure: ", lambda x: x >=0 and x<=10),
            intput("Temperature: ", lambda x: x>=0 and x<=100),
            intput("Hour of day: ", lambda x:x >=0 and x <= 23),
        ))

    def display_measurements(self):
        data = self.__repo.display_pressure_higher(intput("Pressure value: ", lambda x:x >=0 and x<=100))
        print(data)

    def display_avg_pressure(self):
        data = self.__repo.display_avg_pressure_for(intput("Hour of day: ",lambda x:x >=0 and x<=23 ))
        print(data)

    def __init__(self):
        self.__repo = Measurement_Repository([
            Measurement(3.3, 55, 10),
            Measurement(4.0, 30, 11),
            Measurement(2.5, 90, 9),
            Measurement(7.7, 20, 10),
            Measurement(8.9, 60, 11)
        ])
        self.__opts = {
            "1": ("Display all measurements", lambda: print(self.__repo.measurements)),
            "2": ("Add a new measurement", self.add),
            "3": ("Display measurements higher than pressure",self.display_measurements),
            "4": ("Display average pressure and temp for hour of day",self.display_avg_pressure),
            "0": ("Exit", lambda: exit(0))
        }

    def __menu(self):
        print('\033c', end="")
        for key in self.__opts:
            print(f"{key} . {self.__opts[key][0]}")

    def start(self):
        while True:
            self.__menu()
            try:
                opt = input("Pick your desire:")
                self.__opts[opt][1]()
                input("")
            except Exception as e:
                input(e)

