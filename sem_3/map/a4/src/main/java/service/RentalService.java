package service;

import java.util.Date;
import domain.Car;
import domain.Rental;
import repository.CarRepository;
import repository.RentalRepository;
import java.util.UUID;
import domain.RentalStatus;

public class RentalService {
    private RentalRepository rentalRepository;
    private CarRepository carRepository;

    public RentalService(RentalRepository rentalRepository, CarRepository carRepository) {
        this.rentalRepository = rentalRepository;
        this.carRepository = carRepository;
    }

    public Rental createRental(UUID rentalId, UUID carId, Date startDate, Date endDate, String clientName) {
        // Validate rentalId
        if (rentalId == null) {
            throw new IllegalArgumentException("Rental ID cannot be null.");
        }
        // Validate carId and check if car exists
        if (carId == null) {
            throw new IllegalArgumentException("Car ID cannot be null.");
        }

        // Check if car exists
        Car car = carRepository.findById(carId);
        if (car == null) {
            throw new IllegalArgumentException("Car not found for the given ID.");
        }

        // Validate dates
        if (startDate == null || endDate == null) {
            throw new IllegalArgumentException("Start date and end date cannot be null.");
        }
        if (!startDate.before(endDate)) {
            throw new IllegalArgumentException("Start date must be before end date.");
        }

        // Optional: Check if the car is available (assuming an 'isAvailable' flag in Car)
        if (!car.isAvailable()) {
            throw new IllegalArgumentException("Car is not available for rental.");
        }

        // If validations pass, create and add the rental
        Rental rental = new Rental(car.getId(), clientName, startDate, endDate, 12);
        rentalRepository.add(rentalId, rental);
        return rental;
    }

    public void cancelRental(UUID rentalId) {
        // Validate rentalId
        if (rentalId == null) {
            throw new IllegalArgumentException("Rental ID cannot be null.");
        }

        // Check if rental exists and if it is in Pending status
        Rental rental = rentalRepository.findById(rentalId);
        if (rental == null) {
            throw new IllegalArgumentException("Rental not found for the given ID.");
        }
        if (rental.getStatus() != RentalStatus.Pending) {
            throw new IllegalStateException("Only rentals with Pending status can be cancelled.");
        }

        // If validations pass, set the rental status to Cancelled and update
        rental.setStatus(RentalStatus.Cancelled);
        rentalRepository.modify(rentalId, rental);
    }

    public Iterable<Rental> getAllRentals() {
        return rentalRepository.getAll();
    }

    public void createReport() {
    }
}

