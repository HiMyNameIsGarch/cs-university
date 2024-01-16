class Measurement:
    def __init__(self, pressure:float, temp:int, hour_of_day:int):
        self.__pressure = pressure
        self.__hour_of_day = hour_of_day
        self.__temperature = temp

    def __str__(self):
        return f"Pressure: {self.pressure}, Hod: {self.hour_of_day}, Temp: {self.temperature}"
    __repr__ = __str__

    @property
    def pressure(self) -> float:
        return self.__pressure

    @property
    def hour_of_day(self) -> int:
        return self.__hour_of_day

    @property
    def temperature(self) -> int:
        return self.__temperature
