package at.htl.quarkus.demo.model;

import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Entity
@Data
public class Bill {
    @Id
    @GeneratedValue
    private int bill_id;
    private String number;
    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumns({
            @JoinColumn(name = "bill_id", referencedColumnName = "bill_id")
    })
    private List<Line> lines;
}
