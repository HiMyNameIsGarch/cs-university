package repository;

import java.util.List;
import java.util.Map;
import java.util.HashMap;


public abstract class MemoryRepository<ID, T> implements IRepository<ID, T> {
    private Map<ID,T> elements = new HashMap<ID, T>();

    protected Iterable<T> getElements() {
        return elements.values();
    }

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
        return elements.put(id, entityToAdd);
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
        return elements.put(id, entityToModify);
    }

    protected T deleteElement(ID id) {
        if (id == null) {
            throw new IllegalArgumentException("ID cannot be null.");
        }
        return elements.remove(id);
    }

    protected T findElementById(ID id) {
        return elements.get(id);
    }

    @Override
    public Iterable<T> getAll() {
        return getElements();
    }
}
