package repository;

import java.util.List;

public interface IRepository<ID, T> {
    T add(ID Id, T entityToAdd);
    T delete(ID IdToDelete);
    T modify(ID Id, T entityToModify);
    T findById(ID IdToFind);
    Iterable<T> getAll();
}
