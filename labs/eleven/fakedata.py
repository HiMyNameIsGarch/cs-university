from typing import Optional, List
from faker import Faker
from domain.passenger import Passenger
from domain.plane import Plane
from faker_airtravel import AirTravelProvider
from concurrent.futures import ProcessPoolExecutor

fake = Faker()
fake.add_provider(AirTravelProvider)

def generate_passenger(num:int) -> Optional[List[Passenger]]:
    passengers:List[Passenger] = []
    if num <= 0:
        return []
    for _ in range(num):
        passengers.append(Passenger(
            fake.first_name(),
            fake.last_name(),
            fake.ssn()))
    return passengers

# Generate a random number
def generate_planes(num_planes, min_pass, max_pass):
    planes:List[Plane] = []
    for _ in range(num_planes):
        num = fake.random_int(min=50, max=100)
        num_pass = fake.random_int(min=min_pass, max=max_pass)
        flight = fake.flight()
        cplane = Plane(
            nname=flight['origin']['airport'],
            num=flight['destination']['iata'],
            airline_co=flight['airline'],
            no_of_seats=num,
            idestination=flight['destination']['airport'],
            ipassengers=generate_passenger(num_pass))
        planes.append(cplane)
    return planes


# Experimental, don't touch
def gen_threads():
     with ProcessPoolExecutor(8) as exe:
        results = exe.map(generate_planes, [1000000]*8, [100]*8)
        return list(results)
