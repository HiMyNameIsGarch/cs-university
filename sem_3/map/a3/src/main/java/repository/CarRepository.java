package repository;

// IMPORTS

// Utils
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Optional;
import java.util.UUID;

// IO
import java.io.Serializable;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.FileInputStream;
import java.io.ObjectOutputStream;
import java.io.FileOutputStream;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.BufferedReader;
import java.io.FileReader;

// Domain
import domain.Filter.IAbstractFilter;
import domain.Car;
import domain.SettingsParser;
import domain.SerializableType;

public class CarRepository extends FilteredRepository<UUID, Car> {
    // implements the MemoryRepository interface
    public CarRepository(IAbstractFilter<Car> carFilter) {
        super(carFilter, SettingsParser.getSerializableType(SettingsParser.getProperty("CarsType")));
    }

    // java, why in the world don't you have default parameters???????????????
    // I'm not going to write a constructor for each case
    // I'm going to use the default constructor and set the filter later
    // i think i am going crazy, if someone sees this, please reach out to me!
    // this is not a joke, i am really going crazy
    public CarRepository() {
        super(null, SettingsParser.getSerializableType(SettingsParser.getProperty("CarsType")));
    }

    @Override
    protected void saveToFile() throws IOException{
        // save all cars to the file but before that we need to clear the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(fileName))) {
            writer.write("");
        } catch (IOException e) {
            e.printStackTrace();
            throw new IOException("Error writing to file: " + fileName, e);
        }
        for (Car car : getAll()) {
            String carInfo = car.serializeToText();
            // save the car to the file
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(fileName, true))) {
                writer.write(carInfo);
                writer.newLine();
            } catch (IOException e) {
                e.printStackTrace();
                throw new IOException("Error writing to file: " + fileName, e);
            }
        }
    }

    @Override
    protected void loadFromFile() throws IOException{
        // check if the file exists
        if (!new java.io.File(fileName).exists()) {
            return;
        }
        try (BufferedReader reader = new BufferedReader(new FileReader(fileName))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Car car = new Car();
                car.deserializeFromText(line);
                add(car.getId(), car);
            }
        } catch (IOException e) {
            e.printStackTrace();
            throw new IOException("Error reading from file: " + fileName, e);
        }
    }
    @Override
    public Car add(UUID id, Car carToAdd) {
        return addElement(id, carToAdd);
    }

    @Override
    public Car modify(UUID id, Car carToModify) {
        // modify a car from the list
        return modifyElement(id, carToModify);
    }

    @Override
    public Car delete(UUID id) {
        // delete a car from the list
        return deleteElement(id);
    }

    @Override
    public Car findById(UUID id) {
        // find a car by its id
        return findElementById(id);
    }
    @Override
    public Iterable<Car> getAll() {
        // get all cars
        return super.getAll();
    }
}
