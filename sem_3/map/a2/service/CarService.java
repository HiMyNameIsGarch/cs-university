package service;
// in java can i do something like this: for (Cars c : { ... some new Car objects ... }) { ... }

import domain.Car;
import repository.CarRepository;
import java.util.ArrayList;
import java.util.UUID;
import java.util.Arrays;
import java.util.List;
import domain.Filter.FilterCarByModel;
import domain.Filter.IAbstractFilter;

public class CarService {
    private CarRepository carRepository;

    public CarService(CarRepository carRepository) {
        this.carRepository = carRepository;
        initializeSampleData();  // Initialize with some sample data
    }

    public Car createCar(String brand, String model, String licensePlate, boolean isAvailable) {
        // Create base car object
        Car car = new Car();

        // Start populating the properties using the setters
        car.setBrand(brand);
        car.setModel(model);
        car.setLicensePlate(licensePlate);
        car.setAvailable(isAvailable);

        // finally add the car to the repository
        return carRepository.add(car.getId(), car);
    }

    public Car updateCar(UUID id, String brand, String model, String licensePlate, boolean available) {
        // Check if the ID is valid
        if (id == null) {
            throw new IllegalArgumentException("ID cannot be null.");
        }
        Car existingCar = carRepository.findById(id);
        if (existingCar == null) {
            throw new IllegalArgumentException("Car with the given ID does not exist.");
        }

        existingCar.setBrand(brand);
        existingCar.setModel(model);
        existingCar.setLicensePlate(licensePlate);
        existingCar.setAvailable(available);

        // finally update the car in the repository
        return carRepository.modify(id, existingCar);
    }

    public boolean deleteCar(UUID id) {
        if (id == null) {
            throw new IllegalArgumentException("ID cannot be null.");
        }
        return carRepository.delete(id) != null;
    }

    public Car getCarById(UUID id) {
        return carRepository.findById(id);
    }

    public List<Car> getAllCars() {
        Iterable<Car> carsIterable = carRepository.getAll();
        List<Car> carList = new ArrayList<>();
        carsIterable.forEach(carList::add);
        return carList;
    }

    // Initialize the repository with 5 sample cars
    private void initializeSampleData() {
        // add some mock data
        List<Car> cars = Arrays.asList(
            new Car("Toyota", "Corolla", "ABC123", true),
            new Car("Honda", "Civic", "BCU231", false),
            new Car("Ford", "Focus", "MIN345", true));
        for (Car car : cars) {
            carRepository.add(car.getId(), car);
        }
    }

    public List<Car> findCarsByModel(String model) {
        IAbstractFilter<Car> filter = new FilterCarByModel(model);
        // return empty list
        return new ArrayList<>();
        // return carRepository.filter.notify
    }
}
