package at.htl.quarkus.demo.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;
import java.io.Serializable;

@Embeddable
@Data
@EqualsAndHashCode
public class LinePk implements Serializable {
    @Column(name="bill_id")
    private int billId;
    private int row_id;
}
