package ui;

import javafx.collections.FXCollections;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.GridPane;
import javafx.stage.Stage;
import service.CarService;
import service.RentalService;
import domain.Car;
import domain.Rental;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import java.util.UUID;
import java.util.List;
import java.util.Date;

public class RentalScreen {

    private final CarService carService;
    private final RentalService rentalService;

    public RentalScreen(CarService carService, RentalService rentalService) {
        this.carService = carService;
        this.rentalService = rentalService;
    }

    public GridPane getView() {
        GridPane grid = new GridPane();
        grid.setVgap(10);
        grid.setHgap(10);

        // Title
        Label titleLabel = new Label("Car Rental");
        grid.add(titleLabel, 0, 0, 2, 1);

        // Available Cars
        Label carsLabel = new Label("Available Cars:");
        grid.add(carsLabel, 0, 1);

        List<Car> availableCars = carService.getAllCars();
        ComboBox<Car> carComboBox = new ComboBox<>(FXCollections.observableList(availableCars));
        carComboBox.setPromptText("Select a car");
        grid.add(carComboBox, 1, 1);

        // Customer Name
        Label customerLabel = new Label("Customer Name:");
        grid.add(customerLabel, 0, 2);

        TextField customerField = new TextField();
        customerField.setPromptText("Enter customer name");
        grid.add(customerField, 1, 2);

        // Rental Period
        Label rentalPeriodLabel = new Label("Rental Period (days):");
        grid.add(rentalPeriodLabel, 0, 3);

        TextField rentalPeriodField = new TextField();
        rentalPeriodField.setPromptText("Enter rental period");
        grid.add(rentalPeriodField, 1, 3);

        // Rental List
        Label rentalListLabel = new Label("All Rentals:");
        grid.add(rentalListLabel, 0, 4);

        ListView<Rental> rentalListView = new ListView<>();
        rentalListView.setPrefHeight(200);
        grid.add(rentalListView, 1, 4);

        updateRentalList(rentalListView); // Populate rental list initially

        // Submit Button
        Button submitButton = new Button("Submit Rental");
        submitButton.setOnAction(event -> {
            Car selectedCar = carComboBox.getValue();
            String customerName = customerField.getText();
            String rentalPeriod = rentalPeriodField.getText();

            if (selectedCar == null || customerName.isEmpty() || rentalPeriod.isEmpty()) {
                showAlert(Alert.AlertType.ERROR, "Error", "All fields must be filled out.");
                return;
            }

            try {
                int rentalDays = Integer.parseInt(rentalPeriod);
                // Compute start and end dates based on rental days
                Date startDate = new Date();
                Date endDate = new Date(startDate.getTime() + rentalDays * 24 * 60 * 60 * 1000);
                rentalService.createRental(UUID.randomUUID(), selectedCar.getId(), startDate, endDate, customerName);
                showAlert(Alert.AlertType.INFORMATION, "Success", "Rental created successfully!");

                // Refresh data
                carComboBox.setItems(FXCollections.observableList(carService.getAllCars()));
                updateRentalList(rentalListView);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                showAlert(Alert.AlertType.ERROR, "Error", "Rental period must be a number.");
            }
        });
        grid.add(submitButton, 1, 5);

        return grid;
    }

    private void updateRentalList(ListView<Rental> rentalListView) {
        Iterable<Rental> rentalsIterable = rentalService.getAllRentals();
        List<Rental> rentals = StreamSupport.stream(rentalsIterable.spliterator(), false)
        .collect(Collectors.toList());
        rentalListView.setItems(FXCollections.observableList(rentals));
    }

    private void showAlert(Alert.AlertType alertType, String title, String message) {
        Alert alert = new Alert(alertType);
        alert.setTitle(title);
        alert.setContentText(message);
        alert.showAndWait();
    }
}
