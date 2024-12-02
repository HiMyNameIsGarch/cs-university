package repository;

// IMPORTS
import domain.Car;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Optional;
import java.util.UUID;
import domain.Filter.IAbstractFilter;

public class CarRepository extends FilteredRepository<UUID, Car> {
    // implements the MemoryRepository interface
    public CarRepository(IAbstractFilter<Car> carFilter) {
        // constructor
        super(carFilter);
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
