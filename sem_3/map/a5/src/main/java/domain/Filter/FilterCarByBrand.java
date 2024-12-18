package domain.Filter;

import domain.Filter.IAbstractFilter;
import domain.Car;

public class FilterCarByBrand implements IAbstractFilter<Car> {
    private String brand;

    public FilterCarByBrand(String brand) {
        this.brand = brand;
    }

    public boolean accept(Car entity) {
        return entity.getBrand().equals(brand);
    }
}
