package repository;

import domain.Car;
import java.util.UUID;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import repository.CarRepository;

public class CarDatabaseRepository extends CarRepository {
    private final String tableName;
    protected final Connection connection;

    public CarDatabaseRepository(String dbLocation) throws SQLException {
        super(); // Calls the CarRepository constructor for file operations
        this.connection = DriverManager.getConnection("jdbc:sqlite:" + dbLocation); // Initialize the database connection
        this.fileName = dbLocation; // Set the file name for file-based operations
        this.tableName = "Car"; // Set the table name for database operations
        initializeCarTable(); // Create the Car table in the database
    }
    public void initializeCarTable() throws SQLException {
        String createTableQuery =
        "CREATE TABLE IF NOT EXISTS Car (" +
        " id TEXT PRIMARY KEY, " +
        " brand TEXT NOT NULL, " +
        " model TEXT NOT NULL, " +
        " licensePlate TEXT NOT NULL UNIQUE, " +
        " isAvailable BOOLEAN NOT NULL" +
        ");";
        try (Statement stmt = connection.createStatement()) {
            stmt.execute(createTableQuery);

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to initialize Car table.", e);
        } finally {
            System.out.println("Car table initialized.");
        }
    }
        // Override methods to add database-specific functionality

    @Override
    public void load() {
        try {
            // Clear the in-memory storage before loading
            clearMemoryStorage();

            // Fetch all cars from the database
            String query = "SELECT * FROM " + tableName;
            try (Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(query)) {
                while (rs.next()) {
                    // Map each database record to a Car entity
                    // Car car = mapResultSetToEntity(rs);

                    // Add the car to the in-memory storage
                    // add(car.getId(), car);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to load cars from the database.", e);
        }
    }
    private void clearMemoryStorage() {
        for (UUID id : getAllIds()) {
            deleteElement(id); // Remove each element from memory
        }
    }
    private Iterable<UUID> getAllIds() {
        // create a list of all car IDs
        List<UUID> ids = new ArrayList<>();
        for (Car car : getAll()) {
            ids.add(car.getId());
        }
        return ids;
    }


    @Override
    public void save() {
        // No need to implement this method for database-backed repositories
        //
    }

    @Override
    public Car add(UUID id, Car car) {
        try (PreparedStatement stmt = getInsertStatement(id, car)) {
            stmt.executeUpdate();
            return car;
        } catch (SQLException e) {
            throw new RuntimeException("Failed to add car to the database.", e);
        }
    }

    @Override
    public Car modify(UUID id, Car car) {
        try (PreparedStatement stmt = getUpdateStatement(id, car)) {
            stmt.executeUpdate();
            return car;
        } catch (SQLException e) {
            throw new RuntimeException("Failed to modify car in the database.", e);
        }
    }

    @Override
    public Car delete(UUID id) {
        try {
            Car car = findById(id); // Retrieve the car before deletion
            String query = "DELETE FROM Car WHERE id = ?";
            try (PreparedStatement stmt = connection.prepareStatement(query)) {
                stmt.setString(1, id.toString());
                stmt.executeUpdate();
            }
            return car;
        } catch (SQLException e) {
            throw new RuntimeException("Failed to delete car from the database.", e);
        }
    }

    @Override
    public Car findById(UUID id) {
        String query = "SELECT * FROM Car WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, id.toString());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEntity(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to find car in the database.", e);
        }
        return null;
    }

    @Override
    public List<Car> getAll() {
        List<Car> cars = new ArrayList<>();
        String query = "SELECT * FROM Car";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                cars.add(mapResultSetToEntity(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to retrieve all cars from the database.", e);
        }
        return cars;
    }

    private PreparedStatement getInsertStatement(UUID id, Car car) throws SQLException {
        PreparedStatement stmt = connection.prepareStatement(
            "INSERT INTO Car (id, brand, model, licensePlate, isAvailable) VALUES (?, ?, ?, ?, ?)");
        stmt.setString(1, id.toString());
        stmt.setString(2, car.getBrand());
        stmt.setString(3, car.getModel());
        stmt.setString(4, car.getLicensePlate());
        stmt.setBoolean(5, car.isAvailable());
        return stmt;
    }

    private PreparedStatement getUpdateStatement(UUID id, Car car) throws SQLException {
        PreparedStatement stmt = connection.prepareStatement(
            "UPDATE Car SET brand = ?, model = ?, licensePlate = ?, isAvailable = ? WHERE id = ?");
        stmt.setString(1, car.getBrand());
        stmt.setString(2, car.getModel());
        stmt.setString(3, car.getLicensePlate());
        stmt.setBoolean(4, car.isAvailable());
        stmt.setString(5, id.toString());
        return stmt;
    }

    private Car mapResultSetToEntity(ResultSet rs) throws SQLException {
        Car car = new Car(
            rs.getString("brand"),
            rs.getString("model"),
            rs.getString("licensePlate"),
            rs.getBoolean("isAvailable"));
        car.setId(UUID.fromString(rs.getString("id")));
        return car;
    }
}

