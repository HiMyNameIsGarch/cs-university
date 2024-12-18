package domain.Filter;

public interface IAbstractFilter<T> {
    boolean accept(T entity);
}
