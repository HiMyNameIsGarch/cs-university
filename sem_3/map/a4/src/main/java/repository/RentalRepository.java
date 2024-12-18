package repository;

// utils
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
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

// domain
import domain.SettingsParser;
import domain.SerializableType;
import domain.Car;
import domain.Rental;
import domain.Filter.IAbstractFilter;


public class RentalRepository extends MemoryRepository<UUID, Rental> {
    private String path;
    public RentalRepository(String path) {
        super(SettingsParser.getProperty("type"), "rentals");
        this.path = path;
    }
    @Override
    protected void saveToFile() throws IOException{
        // save all rentals to the file but before that we need to clear the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(fileName))) {
            writer.write("");
        } catch (IOException e) {
            e.printStackTrace();
            throw new IOException("Error writing to file: " + fileName, e);
        }
        for (Rental rental : getAll()) {
            String rentalInfo = rental.serializeToText();
            // save the car to the file
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(fileName, true))) {
                writer.write(rentalInfo);
                writer.newLine();
            } catch (IOException e) {
                e.printStackTrace();
                throw new IOException("Error writing to file: " + fileName, e);
            }
        }
    }

    @Override
    protected void loadFromFile() throws IOException{
        // load all cars from the file
        // and add them to the list
        try (BufferedReader reader = new BufferedReader(new FileReader(fileName))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Rental rental = new Rental();
                rental.deserializeFromText(line);
                add(rental.getId(), rental);
            }
        } catch (IOException e) {
            e.printStackTrace();
            throw new IOException("Error reading from file: " + fileName, e);
        }
    }
    @Override
    public Rental add(UUID rentalId, Rental rental) {
        return addElement(rentalId, rental); // Adds the rental to the elements map in MemoryRepository
    }

    @Override
    public Rental modify(UUID rentalId, Rental rental) {
        return modifyElement(rentalId, rental); // Modifies the rental in the elements map
    }

    @Override
    public Rental delete(UUID rentalId) {
        return deleteElement(rentalId); // Deletes the rental from the elements map
    }

    @Override
    public Rental findById(UUID rentalId) {
        return findElementById(rentalId); // Finds the rental by rentalId in the elements map
    }
}
