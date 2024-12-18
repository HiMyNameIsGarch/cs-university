package ui;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;
import repository.RentalDatabaseRepository;
import repository.RentalRepository;
import service.RentalService;
import repository.CarDatabaseRepository;
import service.CarService;
import service.ReportService;
import domain.SettingsParser;

public class FxUI extends Application {

    @Override
    public void start(Stage primaryStage) {
        primaryStage.setTitle("Car Rental Management");

        // Main container for the UI
        BorderPane root = new BorderPane();

        // Example: Start with a placeholder scene
        Scene scene = new Scene(root, 800, 600);

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

            // Initialize and set the main screen (extend functionality later)
            MainScreen mainScreen = new MainScreen(carService, rentalService, reportService);
            root.setCenter(mainScreen.getView());

            primaryStage.setScene(scene);
            primaryStage.show();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) {
        launch(args);
    }
}
