package service;

import domain.Car;
import repository.CarRepository;

import java.util.List;

public class CarService {
    private CarRepository carRepository;

    public CarService() {
        this.carRepository = new CarRepository();
        initializeSampleData();  // Initialize with some sample data
    }

    public Car createCar(String brand, String model, String licensePlate, boolean available) {
        // Create base car object
        Car car = new Car();

        // Start populating the properties using the setters
        car.setId(null);
        car.setBrand(brand);
        car.setModel(model);
        car.setLicensePlate(licensePlate);
        car.setAvailable(available);

        // finally add the car to the repository
        return carRepository.save(car);
    }

    public Car getCarById(int id) {
        return carRepository.findById(id);
    }

    public List<Car> getAllCars() {
        return carRepository.findAll();
    }

    public Car updateCar(int id, String brand, String model, String licensePlate, boolean available) {
        // Try to find the car by the id
        Car existingCar = carRepository.findById(id);

        // If it is present to the following
        if (existingCar != null) {
            // Get the car object
            Car car = existingCar;

            // Start populating the properties using the setters
            car.setBrand(brand);
            car.setModel(model);
            car.setLicensePlate(licensePlate);
            car.setAvailable(available);

            // finally add the car to the repository
            return carRepository.save(car);
        }
        // otherwise return null object
        return null;
    }

    public boolean deleteCar(int id) {
        return carRepository.deleteById(id);
    }

    // Initialize the repository with 5 sample cars
    private void initializeSampleData() {
        // add some mock data
        carRepository.save(new Car(null, "Toyota", "Corolla", "ABC123", true));
        carRepository.save(new Car(null, "Honda", "Civic", "BCU231", false));
        carRepository.save(new Car(null, "Ford", "Focus", "MIN345", true));
    }
}
