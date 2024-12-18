package repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.FileOutputStream;
import java.io.FileInputStream;
import java.io.ObjectOutputStream;
import java.io.ObjectInputStream;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.Serializable;

import domain.SerializableEntity;
import domain.SerializableType;

public abstract class MemoryRepository<ID extends Serializable, T extends Serializable> implements IRepository<ID, T> {
    private Map<ID,T> elements = new HashMap<ID, T>();
    protected final String serializeType;
    protected String fileName = "";

    protected Iterable<T> getElements() {
        return elements.values();
    }

    public MemoryRepository(String type, String fileName) {
        this.serializeType = type;
        this.fileName = fileName;
    }

    @SuppressWarnings("unchecked")
    public void load() throws IOException, ClassNotFoundException{
        // check if the file exists
        if (!new java.io.File(fileName).exists()) {
            return;
        }
        if (serializeType == "txt") {
            loadFromFile();
        } else if (serializeType == "bin") {
            Map<ID, T> deserializedElements = null;
            try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(fileName))) {
                deserializedElements = (Map<ID, T>) ois.readObject();
                System.out.println("Map deserialized from binary file.");
            } catch (IOException e) {
                e.printStackTrace();
                System.err.println("Error during serialization: " + e.getMessage());
            } finally {
                if (deserializedElements != null) {
                    elements = deserializedElements;
                } else {
                    System.out.println("No data loaded from file.");
                    throw new IOException("Error deserializing the map.");
                }
            }

        } else {
            throw new IllegalArgumentException("Invalid serialization type.");
        }
    }

    public void save() throws IOException {
        System.out.println("Saving data to " + fileName + "...");
        if (serializeType == "txt") {
            saveToFile();
        } else if (serializeType == "bin") {
            // Serialize the map to a binary file
            try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(fileName))) {
                // clear the file
                oos.reset();
                oos.writeObject(elements);
                System.out.println("Map serialized to binary file: " + fileName);
            } catch (IOException e) {
                e.printStackTrace();
                System.err.println("Error during deserialization: " + e.getMessage());
            }
        } else {
            throw new IllegalArgumentException("Invalid serialization type.");
        }
    }

    protected abstract void saveToFile() throws IOException;
    protected abstract void loadFromFile() throws IOException;

    protected T addElement(ID id, T entityToAdd) {
        if (id == null) {
            throw new IllegalArgumentException("ID cannot be null.");
        }
        if (entityToAdd == null) {
            throw new IllegalArgumentException("Entity cannot be null.");
        }
        if (elements.containsKey(id)) {
            throw new IllegalArgumentException("An entity with this ID already exists.");
        }
        T entity = elements.put(id, entityToAdd);
        try {
            System.out.println("Saving data to " + fileName + "...");
            save();
        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("Error saving data: " + e.getMessage());
            System.err.println("Data not saved to the file, still in memory.");
        }
        return entity;
    }

    protected T modifyElement(ID id, T entityToModify) {
        if (id == null) {
            throw new IllegalArgumentException("ID cannot be null.");
        }
        if (entityToModify == null) {
            throw new IllegalArgumentException("Entity cannot be null.");
        }
        if (!elements.containsKey(id)) {
            throw new IllegalArgumentException("No entity found with this ID.");
        }
        T entity = elements.put(id, entityToModify);
        try {
            save();
        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("Error saving data: " + e.getMessage());
            System.err.println("Data not saved to the file, still in memory.");
        }
        return entity;
    }

    protected T deleteElement(ID id) {
        if (id == null) {
            throw new IllegalArgumentException("ID cannot be null.");
        }
        T entity = elements.remove(id);
        try {
            save();
        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("Error saving data: " + e.getMessage());
            System.err.println("Data not saved to the file, still in memory.");
        }
        return entity;
    }

    protected T findElementById(ID id) {
        return elements.get(id);
    }

    @Override
    public Iterable<T> getAll() {
        return getElements();
    }
}
