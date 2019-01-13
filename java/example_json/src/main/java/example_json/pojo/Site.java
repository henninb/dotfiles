package example_json.pojo;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

@Setter
@Getter
@ToString
public class Site implements Serializable {
    @JsonProperty("id")
    private String id;

    @JsonProperty("confirmation-times")
    private List<ConfirmationTimes> confirmationTimesList;
    @JsonProperty("alert-distribution-lists")
    private List<AlertDistributionLists> alertDistributionLists;
}

