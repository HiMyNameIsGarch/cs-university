package ui;

import javafx.geometry.Insets;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.VBox;

import service.CarService;
import service.RentalService;
import service.ReportService;
import domain.Car;
import ui.CarScreen;
import ui.RentalScreen;
import ui.ReportScreen;

public class MainScreen {
    private final BorderPane view;

    public MainScreen(CarService carService, RentalService rentalService, ReportService reportService) {
        view = new BorderPane();

        // Sidebar navigation
        VBox sidebar = new VBox(10);
        sidebar.setPadding(new Insets(10));
        sidebar.setStyle("-fx-background-color: #f0f0f0;");

        Button manageCarsBtn = new Button("Manage Cars");
        Button manageRentalsBtn = new Button("Manage Rentals");
        Button viewReportsBtn = new Button("View Reports");

        sidebar.getChildren().addAll(manageCarsBtn, manageRentalsBtn, viewReportsBtn);

        view.setLeft(sidebar);

        // Placeholder for the main content area
        Label placeholder = new Label("Welcome to the Car Rental System");
        view.setCenter(placeholder);

        // Event Handlers for Buttons
        manageCarsBtn.setOnAction(e -> view.setCenter(new CarScreen(carService).getView()));
        manageRentalsBtn.setOnAction(e -> view.setCenter(new RentalScreen(carService, rentalService).getView()));
        viewReportsBtn.setOnAction(e -> view.setCenter(new ReportScreen(reportService).getView()));
    }

    public BorderPane getView() {
        return view;
    }
}
