package example_json.pojo;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

@Setter
@Getter
@ToString
public class ConfirmationTimes implements Serializable {
    @JsonProperty("type")
    private String type;
    @JsonProperty("hour")
    private int hour;
}
