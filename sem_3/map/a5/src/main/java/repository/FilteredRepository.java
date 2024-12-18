package repository;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import domain.Car;
import domain.Filter.IAbstractFilter;
import java.util.UUID;
import java.io.Serializable;
import domain.SerializableType;

public abstract class FilteredRepository<ID extends Serializable, T extends Serializable> extends MemoryRepository<ID, T> {
    public IAbstractFilter<T> filter;

    public FilteredRepository(String type, IAbstractFilter<T> filter) {
        super(type, (filter != null ? "filtered_" : "") + "cars");
        this.filter = filter;
    }

    @Override
    public Iterable<T> getAll() {
        if (filter == null) {
            return super.getAll();
        }
        List<T> filteredElements = new ArrayList<T>();
        for (T entity : getElements()) {
            if (filter.accept(entity)) { filteredElements.add(entity);
            }
        }
        return filteredElements;
    }
}
