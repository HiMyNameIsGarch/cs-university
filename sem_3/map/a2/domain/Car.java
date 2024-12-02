package domain;

import java.util.UUID;

public class Car implements Identifiable<UUID> {

    // private properties
    private UUID id;
    private String brand;
    private String model;
    private String licensePlate;
    private boolean isAvailable;
// no public properties,
    // all of those can be accessed using the public setters

    // constructor with no arguments
    public Car() {
        setId(UUID.randomUUID());
        this.brand = "";
        this.model = "";
        this.licensePlate = "";
        this.isAvailable = false;
    }

    public Car(Car newCar) {
        setId(newCar.getId());
        setBrand(newCar.getBrand());
        setModel(newCar.getModel());
        setLicensePlate(newCar.getLicensePlate());
        setAvailable(newCar.isAvailable());
    }

    // contructor with all arguments
    public Car(String brand, String model, String licensePlate, boolean isAvailable) {
        setId(UUID.randomUUID());
        setBrand(brand);
        setModel(model);
        setLicensePlate(licensePlate);
        setAvailable(isAvailable);
    }

    // Getters and setters

    // ID override the Identifiable interface
    @Override
    public UUID getId() {
        return this.id;
    }
    @Override
    public void setId(UUID id) {
        if (id != null) {
            this.id = id;
        }
        this.id = UUID.randomUUID();
    }

    // Car brand
    public String getBrand() {
        return brand;
    }
    public void setBrand(String brand) {
        if (brand == null || brand.isEmpty()) {
            throw new IllegalArgumentException("Brand cannot be null or empty");
        }
        this.brand = brand;
    }

    // Model
    public String getModel() {
        return model;
    }
    public void setModel(String model) {
        if (model == null || model.isEmpty()) {
            throw new IllegalArgumentException("Model cannot be null or empty");
        }
        this.model = model;
    }

    // License plate
    public String getLicensePlate() {
        return licensePlate;
    }
    public void setLicensePlate(String licensePlate) {
        if (licensePlate == null || licensePlate.isEmpty()) {
            throw new IllegalArgumentException("License plate cannot be null or empty");
        }
        this.licensePlate = licensePlate;
    }

    // Availability
    public boolean isAvailable() {
        return isAvailable;
    }
    public void setAvailable(boolean isAvailable) {
        this.isAvailable = isAvailable;
    }

    // Override the tostring method to show the car details
    @Override
    public String toString() {
        return "Car [id-" + id.toString() + ", brand-" + brand + ", model-" + model + ", licensePlate-" + licensePlate + ", available-" + isAvailable + "]";
    }
}
