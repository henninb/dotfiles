package example_db.entities;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "PERSON")
@Data
public class Person implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name="PERSON_ID")
    private Integer personId;

    @Column(name="FIRST_NAME")
    private String firstName;
}
