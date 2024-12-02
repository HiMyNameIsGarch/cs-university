import domain.Car;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import repository.IRepository;
import service.CarService;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.UUID;
import java.lang.SecurityManager;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class CarServiceTest {
    private IRepository<UUID, Car> mockRepository;
    private CarService carService;



    @BeforeEach
    void setUp() {
        mockRepository = mock(IRepository.class);
        carService = new CarService(mockRepository);
    }

    @Test
    void testAddCar() {
        // Arrange
        Car car = new Car();
        when(mockRepository.add(car.getId(), car)).thenReturn(car);

        // Act
        Car addedCar = carService.addCar(car);

        // Assert
        assertNotNull(addedCar);
        verify(mockRepository, times(1)).add(car.getId(), car);
    }

    @Test
    void testCreateCar() {
        // Arrange
        String brand = "Toyota";
        String model = "Camry";
        String licensePlate = "ABC123";
        boolean isAvailable = true;

        Car car = new Car();
        when(mockRepository.add(any(UUID.class), any(Car.class))).thenReturn(car);

        // Act
        Car createdCar = carService.createCar(brand, model, licensePlate, isAvailable);

        // Assert
        assertNotNull(createdCar);
        verify(mockRepository, times(1)).add(any(UUID.class), any(Car.class));
    }

    @Test
    void testUpdateCarSuccess() {
        // Arrange
        UUID id = UUID.randomUUID();
        Car existingCar = new Car();
        when(mockRepository.findById(id)).thenReturn(existingCar);
        when(mockRepository.modify(id, existingCar)).thenReturn(existingCar);

        // Act
        Car updatedCar = carService.updateCar(id, "Toyota", "Corolla", "XYZ789", true);

        // Assert
        assertNotNull(updatedCar);
        verify(mockRepository, times(1)).findById(id);
        verify(mockRepository, times(1)).modify(id, existingCar);
    }

    @Test
    void testUpdateCarThrowsExceptionForInvalidId() {
        // Act & Assert
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () ->
                carService.updateCar(null, "Toyota", "Corolla", "XYZ789", true));
        assertEquals("ID cannot be null.", exception.getMessage());
    }

    @Test
    void testUpdateCarThrowsExceptionIfCarNotFound() {
        // Arrange
        UUID id = UUID.randomUUID();
        when(mockRepository.findById(id)).thenReturn(null);

        // Act & Assert
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () ->
                carService.updateCar(id, "Toyota", "Corolla", "XYZ789", true));
        assertEquals("Car with the given ID does not exist.", exception.getMessage());
    }

    @Test
    void testDeleteCarSuccess() {
        // Arrange
        UUID id = UUID.randomUUID();
        Car deletedCar = new Car();
        when(mockRepository.delete(id)).thenReturn(deletedCar);

        // Act
        boolean result = carService.deleteCar(id);

        // Assert
        assertTrue(result);
        verify(mockRepository, times(1)).delete(id);
    }

    @Test
    void testDeleteCarFailure() {
        // Arrange
        UUID id = UUID.randomUUID();  // Generate a random UUID
        when(mockRepository.delete(id)).thenReturn(null);  // Simulate that delete returns null (deletion failed)

        // Act
        boolean result = carService.deleteCar(id);  // Call the deleteCar method

        // Assert
        assertFalse(result);  // The result should be false, as delete returned null
        verify(mockRepository, times(1)).delete(id);  // Verify that delete was called exactly once with the provided ID
    }

    @Test
    void testDeleteCarThrowsExceptionForNullId() {
        // Act & Assert
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () ->
                carService.deleteCar(null));
        assertEquals("ID cannot be null.", exception.getMessage());
    }

    @Test
    void testGetCarById() {
        // Arrange
        UUID id = UUID.randomUUID();
        Car car = new Car();
        when(mockRepository.findById(id)).thenReturn(car);

        // Act
        Car result = carService.getCarById(id);

        // Assert
        assertNotNull(result);
        verify(mockRepository, times(1)).findById(id);
    }

    @Test
    void testGetAllCars() {
        // Arrange
        Car car1 = new Car();
        Car car2 = new Car();
        when(mockRepository.getAll()).thenReturn(Arrays.asList(car1, car2));

        // Act
        List<Car> cars = carService.getAllCars();

        // Assert
        assertEquals(2, cars.size());
        verify(mockRepository, times(1)).getAll();
    }

    @Test
    void testSaveRepository() throws IOException, ClassNotFoundException {
        // Act
        carService.getAllCars(); // This triggers the `initRepositoryWithData`

        // Assert
        verify(mockRepository, times(1)).load();
    }

    @Test
    void testFindCarsByModel() {
        // Arrange
        when(mockRepository.getAll()).thenReturn(Collections.emptyList());

        // Act
        List<Car> cars = carService.findCarsByModel("Camry");

        // Assert
        assertTrue(cars.isEmpty());
    }

    @Test
    void testInitRepositoryWithData_Failure(){
        // Arrange: Simulate an exception when loading the cars
        try {
            doThrow(new RuntimeException("File not found")).when(mockRepository).load();

            // Act & Assert: Verify that the method throws the expected exception
            Exception exception = assertThrows(RuntimeException.class, () -> {
                carService.initRepositoryWithData();
            });

            assertTrue(exception.getMessage().contains("Error loading cars from file"));

            // Verify that load was called once
            verify(mockRepository, times(2)).load();
        } catch (Exception e) {
            fail("Exception occurred during test: " + e.getMessage());
        }
    }
}
