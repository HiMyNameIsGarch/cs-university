package repository;

import java.util.List;
import java.io.IOException;

public interface IRepository<ID, T> {
    T add(ID Id, T entityToAdd);
    T delete(ID IdToDelete);
    T modify(ID Id, T entityToModify);
    T findById(ID IdToFind);
    Iterable<T> getAll();
    void save() throws IOException;
    void load() throws IOException, ClassNotFoundException;
}
