package example_db.entities;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "LOC")
@Data
public class Loc implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name="LOC_I")
    private Integer loc;

    @Column(name="CITY_N")
    private String city;

    @Column(name="COUNTRY_N")
    private String country;
}