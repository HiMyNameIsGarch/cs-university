package repository;

import domain.Rental;
import domain.RentalStatus;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import repository.DatabaseRepository;

public class RentalDatabaseRepository extends DatabaseRepository {
    private final String tableName;
    protected final Connection connection;

    public RentalDatabaseRepository(String dbLocation) throws SQLException {
        super(dbLocation); // Call the RentalRepository constructor for file operations
        this.connection = DriverManager.getConnection("jdbc:sqlite:" + dbLocation); // Initialize the database connection
        this.tableName = "Rental";
        initializeRentalTable();
    }
    public void initializeRentalTable() throws SQLException {
        String createTableQuery =
        "CREATE TABLE IF NOT EXISTS " + tableName + " (" +
        "    id TEXT PRIMARY KEY, " +
        "    carId TEXT NOT NULL, " +
        "    clientName TEXT NOT NULL, " +
        "    startDate INTEGER NOT NULL, " +
        "    endDate INTEGER NOT NULL, " +
        "    totalPrice REAL NOT NULL, " +
        "    status TEXT NOT NULL, " +
        "    FOREIGN KEY(carId) REFERENCES Car(id)" +
        ");";
        try (Statement initStatement = connection.createStatement()) {
            initStatement.execute(createTableQuery);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to initialize Rental table.", e);
        } finally {
            System.out.println("Rental table initialized.");
        }
    }

    @Override
    public void load() {
        try {
            // Clear the in-memory repository before loading data from the database
            clearMemoryStorage();

            // Fetch all rentals from the database
            String query = "SELECT * FROM " + tableName;
            try (Statement loadStatement = connection.createStatement();
                 ResultSet resultSet = loadStatement.executeQuery(query)) {
                while (resultSet.next()) {
                    // Map each database record to a Rental entity
                    Rental rental = mapResultSetToEntity(resultSet);

                    // Add the rental to the in-memory storage
                    add(rental.getId(), rental);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to load rentals from the database.", e);
        }
    }

    // Helper method to clear the in-memory storage
    private void clearMemoryStorage() {
        for (UUID id : getAllIds()) {
            deleteElement(id); // Remove each element from the in-memory repository
        }
    }

    // Private utility method to get all UUIDs in memory
    private Iterable<UUID> getAllIds() {
        // create a list of all car IDs
        List<UUID> ids = new ArrayList<>();
        for (Rental rental : getAll()) {
            ids.add(rental.getId());
        }
        return ids;
    }
        // Database-specific implementations
    @Override
    public Rental add(UUID rentalId, Rental rental) {
        try (PreparedStatement addStatement = getInsertStatement(rentalId, rental)) {
            addStatement.executeUpdate();
            return rental;
        } catch (SQLException e) {
            throw new RuntimeException("Failed to add rental to the database.", e);
        }
    }

    @Override
    public Rental modify(UUID rentalId, Rental rental) {
        try (PreparedStatement modifyStatement = getUpdateStatement(rentalId, rental)) {
            modifyStatement.executeUpdate();
            return rental;
        } catch (SQLException e) {
            throw new RuntimeException("Failed to modify rental in the database.", e);
        }
    }



    @Override
    public Rental delete(UUID rentalId) {
        try {
            Rental rental = findById(rentalId);
            String query = "DELETE FROM Rental WHERE id = ?";
            try (PreparedStatement deleteStatement = connection.prepareStatement(query)) {
                deleteStatement.setString(1, rentalId.toString());
                deleteStatement.executeUpdate();
            }
            return rental;
        } catch (SQLException e) {
            throw new RuntimeException("Failed to delete rental from the database.", e);
        }
    }

    @Override
    public Rental findById(UUID rentalId) {
        String query = "SELECT * FROM Rental WHERE id = ?";
        try (PreparedStatement findStatement = connection.prepareStatement(query)) {
            findStatement.setString(1, rentalId.toString());
            try (ResultSet resultSet = findStatement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToEntity(resultSet);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to find rental in the database.", e);
        }
        return null;
    }

    @Override
    public Iterable<Rental> getAll() {
        List<Rental> rentals = new ArrayList<>();
        String query = "SELECT * FROM Rental";
        try (PreparedStatement getAllStatement = connection.prepareStatement(query);
             ResultSet resultSet = getAllStatement.executeQuery()) {
            while (resultSet.next()) {
                rentals.add(mapResultSetToEntity(resultSet));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to retrieve all rentals from the database.", e);
        }
        return rentals;
    }


    private Rental mapResultSetToEntity(ResultSet resultSet) throws SQLException {
        Rental rental = new Rental(
            UUID.fromString(resultSet.getString("carId")),
            resultSet.getString("clientName"),
            new java.util.Date(resultSet.getDate("startDate").getTime()), // Convert java.sql.Date to java.util.Date
            new java.util.Date(resultSet.getDate("endDate").getTime()),
            resultSet.getDouble("totalPrice"));
        rental.setId(UUID.fromString(resultSet.getString("id")));
        rental.setStatus(RentalStatus.valueOf(resultSet.getString("status")));
        return rental;
    }

    private PreparedStatement getInsertStatement(UUID id, Rental rental) throws SQLException {
        PreparedStatement getInsertStatement = connection.prepareStatement(
            "INSERT INTO Rental (id, carId, clientName, startDate, endDate, status, totalPrice) VALUES (?, ?, ?, ?, ?, ?, ?)");
        getInsertStatement.setString(1, id.toString());
        getInsertStatement.setString(2, rental.getCarToReserve().toString());
        getInsertStatement.setString(3, rental.getClientName());
        getInsertStatement.setDate(4, new java.sql.Date(rental.getStartDate().getTime())); // fuckery
        getInsertStatement.setDate(5, new java.sql.Date(rental.getEndDate().getTime()));
        getInsertStatement.setString(6, rental.getStatus().name());
        getInsertStatement.setDouble(7, rental.getTotalPrice());
        return getInsertStatement;
    }

    private PreparedStatement getUpdateStatement(UUID id, Rental rental) throws SQLException {
        PreparedStatement getUpdateStatement = connection.prepareStatement(
            "UPDATE Rental SET carId = ?, clientName = ?, startDate = ?, endDate = ?, status = ?, totalPrice = ? WHERE id = ?");
        getUpdateStatement.setString(1, id.toString());
        getUpdateStatement.setString(2, rental.getClientName());
        getUpdateStatement.setDate(3, new java.sql.Date(rental.getStartDate().getTime())); // fuckery
        getUpdateStatement.setDate(4, new java.sql.Date(rental.getEndDate().getTime()));
        getUpdateStatement.setString(5, rental.getStatus().name());
        getUpdateStatement.setString(6, id.toString());
        getUpdateStatement.setDouble(7, rental.getTotalPrice());
        return getUpdateStatement;
    }
}
