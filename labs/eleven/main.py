from domain.plane import Plane
from domain.passenger import Passenger
from infrastructure.airport_repository import Airport_Repository

plane = Plane("Boeing 747", "N12345", "Delta", 100,
              "Atlanta", [Passenger("John", "Do", "123456789"),
                          Passenger("Mihai", "De", "987654321"),
                          Passenger("Gabi", "Sith", "123456789"),
                          Passenger("Coman", "Mith", "987654321"),
                          Passenger("Razvan", "Marcel", "123456789"),
                          Passenger("Andrei", "Mihai", "987654321"),
                          Passenger("Andreea", "Matei", "123456789"),
                          Passenger("Ana", "Abel", "123456789")])

plane1 = Plane("Boeing 747", "N12345", "Delta", 100,
              "Zimbabue", [Passenger("John", "Do", "123456789"),
                          Passenger("Alex", "Caragiale", "123456789"),
                          Passenger("Marius", "Eminescu", "987654321"),
                          Passenger("Ana", "Abel", "123456789")])

plane22 = Plane("Boeing 747", "N12345", "Delta", 100,
              "Russia", [Passenger("John", "Do", "123456789"),
                          Passenger("Maria", "Ion", "987654321"),
                          Passenger("Lex", "Caragiale", "123456789"),
                          Passenger("Marius", "Eminescu", "987654321"),
                          Passenger("Na", "Bel", "123456789")])

plane3 = Plane("Boeing 747", "N12345", "Delta", 100,
              "Greece", [Passenger("John", "Do", "13456789"),
                          Passenger("Maria", "Ion", "97654321"),
                          Passenger("Alex", "Caragiale", "126789"),
                          Passenger("Alex", "Caragiale", "123456789"),
                          Passenger("Marius", "Eminescu", "987654321"),
                          Passenger("Marius", "Eminescu", "87654321"),
                          Passenger("Ana", "Abel", "23456789")])

ar = Airport_Repository([plane, plane1, plane22, plane3])
p = Plane("Boeing 747", "N12345", "Delta", 100,
              "Greece", [Passenger("John", "Do", "13456789"),
                          Passenger("Maria", "Ion", "97654321"),
                          Passenger("Alex", "Caragiale", "126789"),
                          Passenger("Alex", "Caragiale", "123456789"),
                          Passenger("Marius", "Eminescu", "987654321"),
                          Passenger("Marius", "Eminescu", "87654321"),
                          Passenger("Ana", "Abel", "23456789")])
# 3
print(p.sort_by_last_name())
# 4
print(ar.sort_by_number_of_passengers())
# 5
print(ar.sort_by_no_of_passengers_and_name_starting_with("A"))
# 6
print("bug", ar.sort_by_concat_nums_of_passengers_and_destination())
# 7
print(ar.get_planes_starting_with_the_same_3_letters())
# 8
print(p.get_passengers_starting_with("A"))
# 9
print(ar.get_planes_where_is_the_passenger_named("A"))
