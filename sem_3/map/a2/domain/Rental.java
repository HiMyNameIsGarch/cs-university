package domain;
import java.util.Date;
import java.util.UUID;

public class Rental implements Identifiable<UUID> {

    private UUID id;
    private Car carToReserve;
    private String clientName;
    private Date startDate;
    private Date endDate;
    private double totalPrice;
    private RentalStatus status;

    public Rental() {
        this.id = UUID.randomUUID();
        setCarToReserve(new Car());
        this.clientName = "";
        this.startDate = new Date();
        this.endDate = new Date();
        this.totalPrice = 0.0;
        setStatus(RentalStatus.Pending);
    }

    public Rental(Car carToReserve, String clientName, Date startDate, Date endDate, double totalPrice) {
        setId(UUID.randomUUID());
        setCarToReserve(carToReserve);
        setStartDate(startDate);
        setEndDate(endDate);
        setTotalPrice(totalPrice);
        setClientName(clientName);
        setStatus(RentalStatus.Pending);
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
    public Car getCarToReserve() {
        return carToReserve;
    }
    public void setCarToReserve(Car carToReserve) {
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
