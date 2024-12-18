package ui;

import domain.Car;
import javafx.collections.FXCollections;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.GridPane;
import javafx.stage.Stage;
import service.ReportService;

import java.util.List;
import java.util.Map;
import java.util.UUID;

public class ReportScreen {

    private final ReportService reportService;

    public ReportScreen(ReportService reportService) {
        this.reportService = reportService;
    }

    public GridPane getView() {
        GridPane grid = new GridPane();
        grid.setVgap(10);
        grid.setHgap(10);

        // Title
        Label titleLabel = new Label("Rental Reports");
        grid.add(titleLabel, 0, 0, 2, 1);

        // Report Type
        Label reportLabel = new Label("Select Report:");
        grid.add(reportLabel, 0, 1);

        ComboBox<String> reportTypeComboBox = new ComboBox<>(FXCollections.observableArrayList(
                "Clients by Car", "Cars by Client", "Rental Counts by Status", "Total Revenue", "Cars Rented at Least Once"
        ));
        reportTypeComboBox.setPromptText("Choose a report type");
        grid.add(reportTypeComboBox, 1, 1);

        // Input Field
        Label inputLabel = new Label("Input:");
        TextField inputField = new TextField();
        inputField.setPromptText("Enter relevant data if needed");
        grid.add(inputLabel, 0, 2);
        grid.add(inputField, 1, 2);

        // Generate Button
        Button generateButton = new Button("Generate Report");
        TextArea reportArea = new TextArea();
        reportArea.setEditable(false);
        reportArea.setPrefHeight(200);
        reportArea.setWrapText(true);

        generateButton.setOnAction(event -> {
            String selectedReport = reportTypeComboBox.getValue();
            String userInput = inputField.getText();

            if (selectedReport == null) {
                showAlert(Alert.AlertType.ERROR, "Error", "Please select a report type.");
                return;
            }

            try {
                switch (selectedReport) {
                    case "Clients by Car":
                        if (userInput.isEmpty()) {
                            showAlert(Alert.AlertType.ERROR, "Error", "Please enter a valid Car ID.");
                            return;
                        }
                        UUID carId = UUID.fromString(userInput);
                        List<String> clients = reportService.getClientsByCar(carId);
                        reportArea.setText(String.join("\n", clients));
                        break;

                    case "Cars by Client":
                        if (userInput.isEmpty()) {
                            showAlert(Alert.AlertType.ERROR, "Error", "Please enter a valid Client Name.");
                            return;
                        }
                        List<Car> cars = reportService.getCarsRentedByPerson(userInput);
                        reportArea.setText(cars.toString());
                        break;

                    case "Rental Counts by Status":
                        Map<?, Long> counts = reportService.getRentalCountByStatus();
                        reportArea.setText(counts.toString());
                        break;

                    case "Total Revenue":
                        double revenue = reportService.getTotalRevenue();
                        reportArea.setText("Total Revenue: $" + revenue);
                        break;

                    case "Cars Rented at Least Once":
                        List<Car> rentedCars = reportService.getCarsRentedAtLeastOnce();
                        reportArea.setText(rentedCars.toString());
                        break;

                    default:
                        showAlert(Alert.AlertType.ERROR, "Error", "Unknown report type selected.");
                }
            } catch (IllegalArgumentException e) {
                showAlert(Alert.AlertType.ERROR, "Error", "Invalid input: " + e.getMessage());
            }
        });
        grid.add(generateButton, 1, 3);

        // Report Area
        Label reportContentLabel = new Label("Report Content:");
        grid.add(reportContentLabel, 0, 4);
        grid.add(reportArea, 0, 5, 2, 1);

        return grid;
    }

    private void showAlert(Alert.AlertType alertType, String title, String message) {
        Alert alert = new Alert(alertType);
        alert.setTitle(title);
        alert.setContentText(message);
        alert.showAndWait();
    }
}
