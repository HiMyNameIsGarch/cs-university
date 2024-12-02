package repository;

import domain.Car;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class CarRepository {
    private List<Car> cars = new ArrayList<>();
    private int nextId = 1;

    public Car save(Car car) {
        // check if the id is valid
        if (car.getId() == null) {
            // if not using ints just generate a new UID
            car.setId(nextId++);
            // Add the car
            cars.add(car);
            return car;
        }
        // check if the id is in the list
        // iterate over the id's
        for (Car currentCar : cars) {
            // if the id is in the list
            if (currentCar.getId() == car.getId()) {
                // update the car
                // I miss C++ the equal operator is so much better
                currentCar.setBrand(car.getBrand());
                currentCar.setModel(car.getModel());
                currentCar.setLicensePlate(car.getLicensePlate());
                currentCar.setAvailable(car.isAvailable());
                return currentCar;
            }
        }
        return null;
    }

    public Car findById(int id) {
        for (Car currentCar : cars) {
            if (currentCar.getId() == id) {
                return currentCar;
            }
        }
        return null;
    }

    public List<Car> findAll() {
        return cars;
    }

    public boolean deleteById(int id) {
        // check if the id is in the list
        for (Car car : cars) {
            if (car.getId() == id) {
                return cars.remove(car);
            }
        }
        return false;
    }
}
