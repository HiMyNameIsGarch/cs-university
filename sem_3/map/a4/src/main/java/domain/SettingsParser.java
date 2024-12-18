package domain;

import java.util.Properties;
import java.io.InputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;
import domain.SerializableType;

public final class SettingsParser {
    private final static String SETTINGS_FILE = "settings.properties";

    private final static Properties properties = new Properties();

    // Static block to load the properties file at class loading time
    static {
        try (InputStream input = SettingsParser.class.getClassLoader().getResourceAsStream(SETTINGS_FILE)) {
            if (input == null) {
                throw new IllegalArgumentException("Properties file not found: " + SETTINGS_FILE);
            }
            properties.load(input);
        } catch (IOException ex) {
            throw new RuntimeException("Error reading properties file: " + SETTINGS_FILE, ex);
        }
    }

    // Static method to get a property value by key
    public static String getProperty(String key) {
        return properties.getProperty(key);
    }

}