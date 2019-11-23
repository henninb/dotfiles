package excel_to_db.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import java.math.BigDecimal;
//import java.sql.Date;
import java.util.Date;
import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Transaction {
  @JsonProperty("guid")
  private String guid;

  @JsonProperty("account_type")
  private String accountType;

  @JsonProperty("account_name_owner")
  private String accountNameOwner;

  @JsonProperty("transaction_date")
  private Date transactionDate;

  @JsonProperty("description")
  private String description;

  @JsonProperty("category")
  private String category;

  @JsonProperty("amount")
  private BigDecimal amount;

  @JsonProperty("cleared")
  private int cleared;

  @JsonProperty("notes")
  private String notes;

  @JsonProperty("date_updated")
  private Date dateUpdated;

  @JsonProperty("date_added")
  private Date dateAdded;

  @JsonProperty("reoccurring")
  Boolean reoccurring;

}
