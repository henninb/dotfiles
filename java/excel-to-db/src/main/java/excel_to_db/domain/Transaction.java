import lombok.Data;

@Data
public class Transaction {
  private Long transactionId;
  private String guid;
  private String accountType;
  private String accountNameOwner;
  private String transactionDate;
  private String description;
  private String category;
  private String amount;
  private String isCleared;
  private String notes;
  private String dateUpdated;
  private String dateAdded;
}
