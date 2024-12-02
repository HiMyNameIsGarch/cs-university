package repository;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import domain.Car;
import domain.Rental;
import domain.Filter.IAbstractFilter;
import java.util.UUID;

public class RentalRepository extends MemoryRepository<UUID, Rental> {
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
