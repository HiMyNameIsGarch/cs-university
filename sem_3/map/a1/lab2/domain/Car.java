package domain;

public class Car implements Identifiable<Integer> {

    // private properties
    private Integer id;
    private String brand;
    private String model;
    private String licensePlate;
    private boolean isAvailable;

    // no public properties,
    // all of those can be accessed using the public setters

    // constructor with no arguments
    public Car() {
        this.id = 0;
        this.brand = "";
        this.model = "";
        this.licensePlate = "";
        this.isAvailable = false;
    }

    public Car(Car newCar) {
        this.id = newCar.getId();
        this.brand = newCar.getBrand();
        this.model = newCar.getModel();
        this.licensePlate = newCar.getLicensePlate();
        this.isAvailable = newCar.isAvailable();
    }

    // contructor with all arguments
    public Car(Integer id, String brand, String model, String licensePlate, boolean isAvailable) {
        this.id = id;
        this.brand = brand;
        this.model = model;
        this.licensePlate = licensePlate;
        this.isAvailable = isAvailable;
    }

    // Getters and setters

    // ID override the Identifiable interface
    @Override
    public Integer getId() {
        return id;
    }
    @Override
    public void setId(Integer id) {
        this.id = id;
    }

    // Car brand
    public String getBrand() {
        return brand;
    }
    public void setBrand(String brand) {
        this.brand = brand;
    }

    // Model
    public String getModel() {
        return model;
    }
    public void setModel(String model) {
        this.model = model;
    }

    // License plate
    public String getLicensePlate() {
        return licensePlate;
    }
    public void setLicensePlate(String licensePlate) {
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
        return "Car [id-" + id + ", brand-" + brand + ", model-" + model + ", licensePlate-" + licensePlate + ", available-" + isAvailable + "]";
    }
}
