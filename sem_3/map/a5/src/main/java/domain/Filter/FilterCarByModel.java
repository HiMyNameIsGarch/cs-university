package domain.Filter;

import domain.Filter.IAbstractFilter;
import domain.Car;

public class FilterCarByModel implements IAbstractFilter<Car> {
    private String model;

    public FilterCarByModel(String model) {
        this.model = model;
    }

    public boolean accept(Car entity) {
        return entity.getModel().equals(model);
    }
}
