package ui;

import service.CarService;
import domain.Car;

import java.util.List;
import java.util.Scanner;

public class CarUI {
    private CarService carService;
    private Scanner scanner;

    public CarUI() {
        this.carService = new CarService();
        this.scanner = new Scanner(System.in);
    }

    // helpers
    private void print(String textToPrint) {
        System.out.print(textToPrint);
    }
    private void println(String textToPrint) {
        System.out.println(textToPrint);
    }

    public void displayMenu() {
        while (true) {
            println("\n-- Welcome to the hell of cars --");
            println("1. Add");
            println("2. View");
            println("3. Update");
            println("4. Delete");
            println("5. Quit");
            print("Pick your poison: ");
            int choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    createCar();
                    break;
                case 2:
                    viewAllCars();
                    break;
                case 3:
                    updateCar();
                    break;
                case 4:
                    deleteCar();
                    break;
                case 5:
                    System.exit(0);
                    break;
                default:
                    println("Poison has killed you sorry");
            }
        }
    }

    private void createCar() {
        print("Brand: ");
        String make = scanner.next();

        print("Model: ");
        String model = scanner.next();

        print("License plate: ");
        String licensePlate = scanner.next();

        print("Car available? (true/false): ");
        boolean available = scanner.nextBoolean();

        Car car = carService.createCar(make, model, licensePlate, available);
        println("Wow you got a new car: " + car);
    }

    private void viewAllCars() {
        List<Car> cars = carService.getAllCars();

        if (cars.isEmpty()) {
            println("oops no cars for your today");
        } else {
            for (Car car : cars) {
                println(car.toString());
            }
        }
    }

    private void updateCar() {
        print("Car ID to update: ");
        int id = scanner.nextInt();
        Car car = carService.getCarById(id);

        if (car != null) {
            print("New brand: ");
            String make = scanner.next();

            print("New model: ");
            String model = scanner.next();

            print("New license plate: ");
            String licensePlate = scanner.next();

            print("Car available? (true/false): ");
            boolean available = scanner.nextBoolean();

            Car updatedCar = carService.updateCar(id, make, model, licensePlate, available);
            if (updatedCar != null) {
                println("Wow update on release: " + updatedCar);
            }
        } else {
            println("Car with ID " + id + " not found.");
        }
    }

    private void deleteCar() {
        print("Enter car ID to delete: ");
        int id = scanner.nextInt();

        if (carService.deleteCar(id)) {
            println("The car has crashed.");
        } else {
            println("Car with ID " + id + " not found.");
        }
    }
}
