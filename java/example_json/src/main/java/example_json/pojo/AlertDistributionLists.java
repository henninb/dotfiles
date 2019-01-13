package example_json.pojo;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

@Setter
@Getter
@ToString
public class AlertDistributionLists implements Serializable {
    @JsonProperty("alert-type")
    private String alertType;
    @JsonProperty("send-alerts-to")
    private List<SendAlertsTo> sendAlertsToList;
}
