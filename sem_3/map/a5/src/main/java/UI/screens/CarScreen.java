package ui;

import domain.Car;
import javafx.collections.FXCollections;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.GridPane;
import javafx.stage.Stage;
import service.CarService;
import javafx.scene.input.Clipboard;
import javafx.scene.input.ClipboardContent;

import java.util.List;
import java.util.UUID;

public class CarScreen {

    private final CarService carService;

    public CarScreen(CarService carService) {
        this.carService = carService;
    }

    public GridPane getView() {
        GridPane grid = new GridPane();
        grid.setVgap(10);
        grid.setHgap(10);

        // Title
        Label titleLabel = new Label("Car Management");
        grid.add(titleLabel, 0, 0, 2, 1);

        // Car List
        Label carListLabel = new Label("Available Cars:");
        grid.add(carListLabel, 0, 1);

        List<Car> cars = carService.getAllCars();
        ListView<Car> carListView = new ListView<>(FXCollections.observableArrayList(cars));
        carListView.setPrefHeight(300);
        carListView.setPrefWidth(500);
        grid.add(carListView, 1, 1);

        // Car Details Form
        Label brandLabel = new Label("Brand:");
        grid.add(brandLabel, 0, 2);

        TextField brandField = new TextField();
        grid.add(brandField, 1, 2);

        Label modelLabel = new Label("Model:");
        grid.add(modelLabel, 0, 3);

        TextField modelField = new TextField();
        grid.add(modelField, 1, 3);

        Label licensePlateLabel = new Label("License Plate:");
        grid.add(licensePlateLabel, 0, 4);

        TextField licensePlateField = new TextField();
        grid.add(licensePlateField, 1, 4);

        Label availableLabel = new Label("Available:");
        grid.add(availableLabel, 0, 5);

        CheckBox availableCheckBox = new CheckBox();
        grid.add(availableCheckBox, 1, 5);

        // Buttons
        Button addButton = new Button("Add Car");
        addButton.setOnAction(event -> {
            String brand = brandField.getText();
            String model = modelField.getText();
            String licensePlate = licensePlateField.getText();
            boolean isAvailable = availableCheckBox.isSelected();

            if (brand.isEmpty() || model.isEmpty() || licensePlate.isEmpty()) {
                showAlert(Alert.AlertType.ERROR, "Error", "All fields must be filled out.");
                return;
            }

            try {
                Car car = carService.createCar(brand, model, licensePlate, isAvailable);
                carListView.getItems().add(car);
                clearForm(brandField, modelField, licensePlateField, availableCheckBox);
                showAlert(Alert.AlertType.INFORMATION, "Success", "Car added successfully!");
            } catch (IllegalArgumentException e) {
                showAlert(Alert.AlertType.ERROR, "Error", e.getMessage());
            }
        });

        Button editButton = new Button("Edit Car");
        editButton.setOnAction(event -> {
            Car selectedCar = carListView.getSelectionModel().getSelectedItem();
            if (selectedCar == null) {
                showAlert(Alert.AlertType.ERROR, "Error", "No car selected.");
                return;
            }

            String brand = brandField.getText();
            String model = modelField.getText();
            String licensePlate = licensePlateField.getText();
            boolean isAvailable = availableCheckBox.isSelected();

            if (brand.isEmpty() || model.isEmpty() || licensePlate.isEmpty()) {
                showAlert(Alert.AlertType.ERROR, "Error", "All fields must be filled out.");
                return;
            }

            try {
                Car updatedCar = carService.updateCar(selectedCar.getId(), brand, model, licensePlate, isAvailable);
                carListView.getItems().set(carListView.getSelectionModel().getSelectedIndex(), updatedCar);
                clearForm(brandField, modelField, licensePlateField, availableCheckBox);
                showAlert(Alert.AlertType.INFORMATION, "Success", "Car updated successfully!");
            } catch (IllegalArgumentException e) {
                showAlert(Alert.AlertType.ERROR, "Error", e.getMessage());
            }
        });

        Button deleteButton = new Button("Delete Car");
        deleteButton.setOnAction(event -> {
            Car selectedCar = carListView.getSelectionModel().getSelectedItem();
            if (selectedCar == null) {
                showAlert(Alert.AlertType.ERROR, "Error", "No car selected.");
                return;
            }

            try {
                boolean success = carService.deleteCar(selectedCar.getId());
                if (success) {
                    carListView.getItems().remove(selectedCar);
                    clearForm(brandField, modelField, licensePlateField, availableCheckBox);
                    showAlert(Alert.AlertType.INFORMATION, "Success", "Car deleted successfully!");
                } else {
                    showAlert(Alert.AlertType.ERROR, "Error", "Failed to delete the car.");
                }
            } catch (IllegalArgumentException e) {
                showAlert(Alert.AlertType.ERROR, "Error", e.getMessage());
            }
        });


        Button copyUuidButton = new Button("Copy UUID");
        copyUuidButton.setOnAction(event -> {
            Car selectedCar = carListView.getSelectionModel().getSelectedItem();
            if (selectedCar == null) {
                showAlert(Alert.AlertType.ERROR, "Error", "No car selected.");
                return;
            }

            Clipboard clipboard = Clipboard.getSystemClipboard();
            ClipboardContent content = new ClipboardContent();
            content.putString(selectedCar.getId().toString());
            clipboard.setContent(content);

            showAlert(Alert.AlertType.INFORMATION, "Success", "Car UUID copied to clipboard!");
        });

        // Layout buttons
        grid.add(addButton, 0, 6);
        grid.add(editButton, 1, 6);
        grid.add(deleteButton, 0, 7);
        grid.add(copyUuidButton, 1, 7);

        return grid;
    }

    private void clearForm(TextField brandField, TextField modelField, TextField licensePlateField, CheckBox availableCheckBox) {
        brandField.clear();
        modelField.clear();
        licensePlateField.clear();
        availableCheckBox.setSelected(false);
    }

    private void showAlert(Alert.AlertType alertType, String title, String message) {
        Alert alert = new Alert(alertType);
        alert.setTitle(title);
        alert.setContentText(message);
        alert.showAndWait();
    }
}

