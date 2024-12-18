package domain;

public interface Identifiable<T> {
    // Get the id for and object of type T ( used for the Car class )
    T getId();
    // Set the id for the same object of type T return nothing
    void setId(T id);
}
