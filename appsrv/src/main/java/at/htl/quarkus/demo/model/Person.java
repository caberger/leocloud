package at.htl.quarkus.demo.model;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Data
@Entity
public class Person {
    @Id
    @GeneratedValue
    private Integer id;

    private String firstName;
    private String lastName;
    private String matNr;
    @ManyToOne
    private Course course;

    public String fullName() {
        var sb = new StringBuilder();
        if (firstName != null) {
            sb.append(firstName);
        }
        if (lastName != null) {
            if (sb.length() > 0) {
                sb.append(" ");
            }
            sb.append(lastName);
        }
        return sb.toString();
    }
}
