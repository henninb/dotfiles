package example_json.pojo;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

@Setter
@Getter
@ToString
public class SendAlertsTo implements Serializable {
    @JsonProperty("addressee")
    private String addressee;
    @JsonProperty("type")
    private String type;
}


