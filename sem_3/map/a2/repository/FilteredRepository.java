package repository;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import domain.Car;
import domain.Filter.IAbstractFilter;
import java.util.UUID;

public abstract class FilteredRepository<ID, T> extends MemoryRepository<ID, T> {
    public IAbstractFilter<T> filter;

    public FilteredRepository(IAbstractFilter<T> filter) {
        this.filter = filter;
    }

    @Override
    public Iterable<T> getAll() {
        List<T> filteredElements = new ArrayList<T>();
        for (T entity : getElements()) {
            if (filter.accept(entity)) { filteredElements.add(entity);
            }
        }
        return filteredElements;
    }
}
