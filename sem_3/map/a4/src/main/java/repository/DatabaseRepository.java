package repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// Base repository for database-backed entities
public abstract class DatabaseRepository<ID, T> implements IRepository<ID, T> {
    private final String tableName;
    protected final Connection connection;

    public DatabaseRepository(String tableName, Connection connection) {
        this.tableName = tableName;
        this.connection = connection;
    }

    public DatabaseRepository(String tableName, String dbLocation) throws SQLException {
        this.tableName = tableName;
        this.connection = DriverManager.getConnection("jdbc:sqlite:" + dbLocation);
    }

    @Override
    public void load() {
        // No need to implement this method for database-backed repositories
        //
    }

    @Override
    public void save() {
        // No need to implement this method for database-backed repositories
        //
    }

    @Override
    public T add(ID id, T entityToAdd) {
        try (PreparedStatement addEntityStatement = getInsertStatement(id, entityToAdd)) {
            addEntityStatement.executeUpdate();
            return entityToAdd;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to add entity", e);
        }
    }

    @Override
    public T delete(ID idToDelete) {
        T entity = findById(idToDelete);
        if (entity == null) {
            return null;
        }
        try (PreparedStatement deleteStatement = connection.prepareStatement("DELETE FROM " + tableName + " WHERE id = ?")) {
            deleteStatement.setObject(1, idToDelete);
            deleteStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return entity;
    }

    @Override
    public T modify(ID id, T entityToModify) {
        try (PreparedStatement modifyStatement = getUpdateStatement(id, entityToModify)) {
            modifyStatement.executeUpdate();
            return entityToModify;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to modify entity", e);
        }
    }

    @Override
    public T findById(ID idToFind) {
        try (PreparedStatement findStatement = connection.prepareStatement("SELECT * FROM " + tableName + " WHERE id = ?")) {
            findStatement.setObject(1, idToFind);
            ResultSet resultSet = findStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToEntity(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Iterable<T> getAll() {
        List<T> entities = new ArrayList<>();
        try (Statement getAllStatement = connection.createStatement();
             ResultSet rs = getAllStatement.executeQuery("SELECT * FROM " + tableName)) {
            while (rs.next()) {
                entities.add(mapResultSetToEntity(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return entities;
    }

    // Abstract methods to implement for specific entities
    protected abstract PreparedStatement getInsertStatement(ID id, T entity) throws SQLException;

    protected abstract PreparedStatement getUpdateStatement(ID id, T entity) throws SQLException;

    protected abstract T mapResultSetToEntity(ResultSet rs) throws SQLException;
}

