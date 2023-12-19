from typing import Optional, List
from faker import Faker

from domain.passenger import Passenger
from domain.plane import Plane
fake = Faker()

def generate_passenger(num:int) -> Optional[List[Passenger]]:
    passengers:List[Passenger] = []
    for _ in range(num):
        passengers.append(Passenger(
            fake.first_name(),
            fake.last_name(),
            fake.ssn()))
    return passengers

# Generate a random number
def generate_planes(num_planes, num_passengers_per_plane):
    planes:List[Plane] = []
    for _ in range(num_planes):
        num = fake.random_int(min=50, max=100)
        cplane = Plane(
            nname=fake.name(),
            num=fake.ssn(),
            airline_co=fake.company(),
            no_of_seats=num,
            idestination=fake.company(),
            ipassengers=generate_passenger(num_passengers_per_plane))
        planes.append(cplane)
    return planes
