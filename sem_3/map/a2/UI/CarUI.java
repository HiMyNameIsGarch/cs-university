package ui;

// custom imports
import service.CarService;
import service.RentalService;
import repository.CarRepository;
import repository.RentalRepository;
import domain.Car;
import domain.Rental;
import domain.RentalStatus;
import domain.Filter.FilterCarByModel;
import domain.Filter.IAbstractFilter;

// java imports
import java.util.Date;
import java.util.List;
import java.util.Scanner;
import java.util.UUID;

public class CarUI {
    private static final Scanner scanner = new Scanner(System.in);

    // Apply a simple filter to initialize CarRepository, e.g., filter cars by model "Corolla"
    private static final IAbstractFilter<Car> carFilter = new FilterCarByModel("Corolla");
    private static final CarRepository carRepository = new CarRepository(carFilter);
    private static final RentalRepository rentalRepository = new RentalRepository();

    private static final CarService carService = new CarService(carRepository);
    private static final RentalService rentalService = new RentalService(rentalRepository, carRepository);

    private final int ADD_OPTION = 1;
    private final int VIEW_OPTION = 2;
    private final int UPDATE_OPTION = 3;
    private final int DELETE_OPTION = 4;
    private final int FIND_BY_MANUFACTURER_OPTION = 5;
    private final int CREATE_RENTAL_OPTION = 6;
    private final int VIEW_RENTALS_OPTION = 7;
    private final int CANCEL_RENTAL_OPTION = 8;
    private final int QUIT_OPTION = 0;

    // helpers
    private void print(String textToPrint) {
        System.out.print(textToPrint);
    }
    private void println(String textToPrint) {
        System.out.println(textToPrint);
    }

    public void start() {
        while (true) {
            displayMenu();
            int choice = Integer.parseInt(scanner.nextLine());

            switch (choice) {
                case ADD_OPTION -> addCar();
                case VIEW_OPTION -> listAllCars();
                case UPDATE_OPTION -> updateCar();
                case DELETE_OPTION -> deleteCar();
                case FIND_BY_MANUFACTURER_OPTION -> findCarsByManufacturer();
                case CREATE_RENTAL_OPTION -> createRental();
                case VIEW_RENTALS_OPTION -> listAllRentals();
                case CANCEL_RENTAL_OPTION -> cancelRental();
                case QUIT_OPTION -> {
                    System.out.println("Exiting...");
                    System.exit(0);
                }
                default -> System.out.println("Invalid choice. Please try again.");
            }
        }
    }

    public void displayMenu() {
        println("\n-- Welcome to the hell of cars --");
        println("1. Add a new Car");
        println("2. List all Cars (filtered)");
        println("3. Update a Car");
        println("4. Delete a Car");
        println("5. Find the Cheapest Car");
        println("6. Find Cars by Manufacturer");
        println("7. Create a Rental");
        println("8. List all Rentals");
        println("9. Cancel a Rental");
        println("0. Exit");
        print("Pick your poison: ");
    }

    public void addCar() {
        print("Enter car brand: ");
        String brand = scanner.nextLine();
        print("Enter car model: ");
        String model = scanner.nextLine();
        print("Enter license plate: ");
        String licensePlate = scanner.nextLine();
        print("Is the car available (true/false): ");
        boolean isAvailable = Boolean.parseBoolean(scanner.nextLine());

        try {
            carService.createCar(brand, model, licensePlate, isAvailable);
            System.out.println("Car added successfully!");
        } catch (IllegalArgumentException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    private void listAllCars() {
        System.out.println("Listing all cars (filtered by active filter):");
        List<Car> cars = carService.getAllCars();
        if (cars.isEmpty()) {
            System.out.println("No cars available.");
        } else {
            cars.forEach(System.out::println);
        }
    }

    private void updateCar() {
        System.out.print("Enter car ID to update: ");
        UUID carId = UUID.fromString(scanner.nextLine());

        System.out.print("Enter new brand (leave blank to skip): ");
        String brand = scanner.nextLine();
        System.out.print("Enter new model (leave blank to skip): ");
        String model = scanner.nextLine();
        System.out.print("Enter new license plate (leave blank to skip): ");
        String licensePlate = scanner.nextLine();
        System.out.print("Is the car available (true/false): ");
        boolean isAvailable = Boolean.parseBoolean(scanner.nextLine());

        try {
            Car updatedCar = carService.updateCar(carId, brand, model, licensePlate, isAvailable);
            if (updatedCar != null) {
                System.out.println("Car updated successfully!");
            } else {
                System.out.println("Car not found.");
            }
        } catch (IllegalArgumentException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    private void deleteCar() {
        System.out.print("Enter car ID to delete: ");
        UUID carId = UUID.fromString(scanner.nextLine());
        if (carService.deleteCar(carId)) {
            System.out.println("Car deleted successfully!");
        } else {
            System.out.println("Car not found.");
        }
    }

    private void findCarsByManufacturer() {
        System.out.print("Enter manufacturer to search: ");
        List<Car> cars = carService.getAllCars();
        if (cars.isEmpty()) {
            System.out.println("No cars found for the given manufacturer.");
        } else {
            cars.forEach(System.out::println);
        }
    }

    // Rental Operations

    private void createRental() {
        System.out.print("Enter car ID for rental: ");
        UUID carId = UUID.fromString(scanner.nextLine());
        System.out.print("Enter rental start date (in ms): ");
        Date startDate = new Date(Long.parseLong(scanner.nextLine()));
        System.out.print("Enter rental end date (in ms): ");
        Date endDate = new Date(Long.parseLong(scanner.nextLine()));

        UUID rentalId = UUID.randomUUID();
        try {
            // Call createRental on rentalService with all required parameters
            rentalService.createRental(rentalId, carId, startDate, endDate);
            System.out.println("Rental created successfully!");
        } catch (IllegalArgumentException e) {
            System.out.println("Error creating rental: " + e.getMessage());
        }
    }

    private void listAllRentals() {
        Iterable<Rental> rentals = rentalService.getAllRentals();
        rentals.forEach(System.out::println);
    }

    private void cancelRental() {
        System.out.print("Enter rental ID to cancel: ");
        UUID rentalId = UUID.fromString(scanner.nextLine());
        try {
            rentalService.cancelRental(rentalId);
            System.out.println("Rental cancelled successfully!");
        } catch (IllegalArgumentException | IllegalStateException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }


}
