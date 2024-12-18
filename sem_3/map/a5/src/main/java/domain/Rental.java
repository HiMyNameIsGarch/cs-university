package domain;
import java.util.Date;
import java.util.UUID;
import domain.SerializableEntity;
import domain.Identifiable;
import java.io.IOException;
import java.io.Serializable;
import java.io.ObjectInputStream;
import java.io.FileInputStream;
import java.io.Serializable;

public class Rental implements Identifiable<UUID>, SerializableEntity<Rental>, Serializable {

    private final char delim = '|';
    private final static long serialVersionUID = 1L;
    private UUID id;
    private UUID carToReserve;
    private String clientName;
    private Date startDate;
    private Date endDate;
    private double totalPrice;
    private RentalStatus status;

    public Rental() {
        setId(UUID.randomUUID());
        setCarToReserve(UUID.randomUUID());
        setClientName("");
        setStartDate(new Date());
        setEndDate(new Date());
        setTotalPrice(0.0);
        setStatus(RentalStatus.Pending);
    }

    public Rental(UUID carToReserve, String clientName, Date startDate, Date endDate, double totalPrice) {
        setId(UUID.randomUUID());
        setCarToReserve(carToReserve);
        this.startDate = startDate;
        setEndDate(endDate);
        setTotalPrice(totalPrice);
        setClientName(clientName);
        setStatus(RentalStatus.Pending);
    }

    @Override
    public Rental deserializeFromBinary(String filePath) throws IOException, ClassNotFoundException {
        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filePath))) {
            return (Rental) ois.readObject();
        }
    }

    // Implementing serializeToText from SerializableEntity
    @Override
    public String serializeToText() throws IOException {
        return id.toString() + delim +
                carToReserve.toString() + delim +  // Serialize car ID
                clientName + delim +
                startDate.getTime() + delim +  // Serialize as milliseconds
                endDate.getTime() + delim +
                totalPrice + delim +
                status.toString();
    }

    // Static method to deserialize text into a Rental object
    public Rental deserializeFromText(String line) throws IOException {
        try {
            String[] parts = line.split(String.valueOf(delim));
            UUID id = UUID.fromString(parts[0]);
            UUID carID = UUID.fromString(parts[1]);
            // should we compute  the  commas in carline to get the rest of the information?
            String clientName = parts[2];
            Date startDate = new Date(Long.parseLong(parts[3]));
            Date endDate = new Date(Long.parseLong(parts[4]));
            double totalPrice = Double.parseDouble(parts[5]);
            RentalStatus status = RentalStatus.valueOf(parts[6]);

            // You may want to retrieve the Car object from a repository using carId

            Rental rental = new Rental(carID, clientName, startDate, endDate, totalPrice);
            rental.setId(id);
            rental.setStatus(status);
            return rental;
        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("Failed to deserialize Rental", e);
        }
    }

    @Override
    public UUID getId() {
        return id;
    }
    @Override
    public void setId(UUID id) {
        this.id = id;
    }
    //getter and setter for status
    public RentalStatus getStatus() {
        return status;
    }
    public void setStatus(RentalStatus status) {
        if (status == null) {
            throw new IllegalArgumentException("Status cannot be null");
        }
        this.status = status;
    }

    // getters and setters
    public UUID getCarToReserve() {
        return carToReserve;
    }
    public void setCarToReserve(UUID carToReserve) {
        if (carToReserve == null) {
            throw new IllegalArgumentException("Car to reserve cannot be null");
        }
        this.carToReserve = carToReserve;
    }
    public String getClientName() {
        return clientName;
    }
    public void setClientName(String clientName) {
        if (clientName == null || clientName.isEmpty()) {
            throw new IllegalArgumentException("Client name cannot be empty");
        }
        this.clientName = clientName;
    }
    public Date getStartDate() {
        return startDate;
    }
    public void setStartDate(Date startDate) {
        if (startDate.after(endDate)) {
            throw new IllegalArgumentException("Start date cannot be after end date");
        }
        this.startDate = startDate;
    }
    public Date getEndDate() {
        return endDate;
    }
    public void setEndDate(Date endDate) {
        if (endDate.before(startDate)) {
            throw new IllegalArgumentException("End date cannot be before start date");
        }
        this.endDate = endDate;
    }
    public double getTotalPrice() {
        return totalPrice;
    }
    public void setTotalPrice(double totalPrice) {
        if (totalPrice < 0) {
            throw new IllegalArgumentException("Total price cannot be negative");
        }
        this.totalPrice = totalPrice;
    }
    //toString method
    @Override
    public String toString() {
        return "Rental{" +
                "id=" + id +
                ", carToReserve=" + carToReserve +
                ", clientName='" + clientName + '\'' +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", totalPrice=" + totalPrice +
                ", status=" + status +
                '}';
    }
}
