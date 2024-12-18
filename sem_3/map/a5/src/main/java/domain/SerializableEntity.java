package domain;

import java.io.ObjectInputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;

public interface SerializableEntity<T> {

    // Serialize the object to text format (abstract method for each entity)
    String serializeToText() throws IOException;

    // Deserialize a text line into the object (abstract method for each entity)
    T deserializeFromText(String line) throws IOException;

    // Default binary serialization (common for all entities)
    default void serializeToBinary(String filePath) throws IOException {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(filePath))) {
            oos.writeObject(this);
        }
    }

    // Default binary deserialization (common for all entities)
    T deserializeFromBinary(String filePath) throws IOException, ClassNotFoundException;

}

