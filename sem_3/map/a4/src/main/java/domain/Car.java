package domain;

import java.util.UUID;
import domain.SerializableEntity;
import domain.Identifiable;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.FileInputStream;
import java.io.Serializable;

public class Car implements Identifiable<UUID>, SerializableEntity<Car>, Serializable{

    // private properties
    private final static long serialVersionUID = 1L;
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

    @Override
    public String serializeToText() throws IOException {
        return id.toString() + "," + brand + "," + model + "," + licensePlate + "," + isAvailable;
    }

    @Override
    public Car deserializeFromBinary(String filePath) throws IOException, ClassNotFoundException {
        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filePath))) {
            return (Car) ois.readObject();
        }
    }

    public Car deserializeFromText(String line) throws IOException {
        try {
            String[] parts = line.split(",");
            setId(UUID.fromString(parts[0]));
            setBrand(parts[1]);
            setModel(parts[2]);
            setLicensePlate(parts[3]);
            setAvailable(Boolean.parseBoolean(parts[4]));
            return this;
        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("Failed to deserialize Car", e);
        }
    }

    // Getters and setters

    // ID override the Identifiable interface
    @Override
    public UUID getId() {
        return this.id;
    }
    @Override
    public void setId(UUID id) {
        if (id == null) {
            throw new IllegalArgumentException("ID cannot be null");
        }
        this.id = id;
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
        return "Car [id-" + this.id.toString() + ", brand-" + brand + ", model-" + model + ", licensePlate-" + licensePlate + ", available-" + isAvailable + "]";
    }
}
