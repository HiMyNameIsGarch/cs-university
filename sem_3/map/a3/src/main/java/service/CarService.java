package service;

import domain.Car;
import repository.CarRepository;
import java.util.ArrayList;
import java.util.UUID;
import java.util.Arrays;
import java.util.List;
import domain.Filter.FilterCarByModel;
import domain.Filter.IAbstractFilter;
import repository.IRepository;

public class CarService {
    private IRepository<UUID, Car> carRepository;

    public CarService(IRepository<UUID, Car> carRepository) {
        this.carRepository = carRepository;
        initRepositoryWithData();  // Initialize with some sample data
    }

    public Car addCar(Car car) {
        return carRepository.add(car.getId(), car);
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
    public void initRepositoryWithData() throws RuntimeException {
        // load the cars from the file
        try {
            System.out.println("Loading cars from file...");
            carRepository.load();

        } catch (Exception e) {
            throw new RuntimeException("Error loading cars from file: " + e.getMessage());
        } finally {
            System.out.println("Cars loaded successfully.");
        }
    }

    public List<Car> findCarsByModel(String model) {
        IAbstractFilter<Car> filter = new FilterCarByModel(model);
        // return empty list
        return new ArrayList<>();
        // return carRepository.filter.notify
    }
}
