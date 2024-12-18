import ui.MainUI;
import domain.SettingsParser;
import repository.IRepository;
import repository.CarDatabaseRepository;
import repository.RentalDatabaseRepository;
import repository.RentalRepository;
import repository.CarRepository;
import domain.Rental;
import java.util.UUID;
import service.RentalService;
import service.CarService;
import domain.Car;
import domain.Rental;
import domain.RentalStatus;
import service.ReportService;
// import date
import java.util.Date;

public class Main {
    public static void main(String[] args) {
        // Initialize and run the Car UI
        // get the properties from the settings.
        String repositoryType = SettingsParser.getProperty("repository");
        String dataPath = SettingsParser.getProperty("path");
        RentalRepository repo = null;
        System.out.println(repositoryType + " is the type");
        try {
            if (repositoryType.equals("db")) {
                repo = new RentalDatabaseRepository(dataPath);
            } else if (repositoryType == "file" || repositoryType == "memory") {
                repo = new RentalRepository(dataPath);
            }

            CarDatabaseRepository carRepository = new CarDatabaseRepository(dataPath);


            RentalService rentalService = new RentalService(repo, carRepository);


            CarService carService = new CarService(carRepository);

            // initData(carRepository, repo);
            //
            ReportService reportService = new ReportService(carRepository, repo);

            MainUI ui = new MainUI(rentalService, carService, reportService);

            ui.start();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    private static void initData(CarDatabaseRepository carRepository, RentalRepository rentalRepository) {
        try {
            // Add sample cars
            Car car1 = new Car("Toyota", "Corolla", "ABC123", true);
            Car car2 = new Car("Honda", "Civic", "XYZ789", true);
            Car car3 = new Car("Tesla", "Model 3", "TESLA01", true);
            Car car4 = new Car("Ford", "Focus", "FORD12", true);
            Car car5 = new Car("BMW", "X5", "BMWX5", true);

            carRepository.add(car1.getId(), car1);
            carRepository.add(car2.getId(), car2);
            carRepository.add(car3.getId(), car3);
            carRepository.add(car4.getId(), car4);
            carRepository.add(car5.getId(), car5);

            // Get the current date for start dates
            Date currentDate = new Date();
            long oneDayInMillis = 24 * 60 * 60 * 1000; // 1 day in milliseconds

            // Add sample rentals with proper start and end dates
            Rental rental1 = new Rental(car1.getId(), "Alice", currentDate, new Date(currentDate.getTime() + oneDayInMillis), 200.0);
            rental1.setStatus(RentalStatus.Active);

            Rental rental2 = new Rental(car2.getId(), "Bob", currentDate, new Date(currentDate.getTime() + oneDayInMillis * 3), 150.0);
            rental2.setStatus(RentalStatus.Pending);

            Rental rental3 = new Rental(car1.getId(), "Charlie", currentDate, new Date(currentDate.getTime() + oneDayInMillis * 5), 250.0);
            rental3.setStatus(RentalStatus.Cancelled);

            Rental rental4 = new Rental(car3.getId(), "Alice", currentDate, new Date(currentDate.getTime() + oneDayInMillis * 7), 300.0);
            rental4.setStatus(RentalStatus.Active);

            Rental rental5 = new Rental(car4.getId(), "David", currentDate, new Date(currentDate.getTime() + oneDayInMillis * 11), 120.0);
            rental5.setStatus(RentalStatus.Pending);

            Rental rental6 = new Rental(car2.getId(), "Charlie", currentDate, new Date(currentDate.getTime() + oneDayInMillis * 8), 180.0);
            rental6.setStatus(RentalStatus.Active);

            Rental rental7 = new Rental(car5.getId(), "Alice", currentDate, new Date(currentDate.getTime() + oneDayInMillis * 4), 500.0);
            rental7.setStatus(RentalStatus.Active);

            Rental rental8 = new Rental(car5.getId(), "Eve", currentDate, new Date(currentDate.getTime() + oneDayInMillis * 2), 550.0);
            rental8.setStatus(RentalStatus.Active);

            // Save rentals to the repository
            rentalRepository.add(rental1.getId(), rental1);
            rentalRepository.add(rental2.getId(), rental2);
            rentalRepository.add(rental3.getId(), rental3);
            rentalRepository.add(rental4.getId(), rental4);
            rentalRepository.add(rental5.getId(), rental5);
            rentalRepository.add(rental6.getId(), rental6);
            rentalRepository.add(rental7.getId(), rental7);
            rentalRepository.add(rental8.getId(), rental8);

            System.out.println("Sample data added successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

}
