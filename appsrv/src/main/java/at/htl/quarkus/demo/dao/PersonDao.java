package at.htl.quarkus.demo.dao;

import at.htl.quarkus.demo.model.Person;

import javax.enterprise.context.Dependent;
import javax.inject.Inject;
import javax.inject.Named;
import javax.persistence.EntityManager;
import javax.validation.constraints.NotNull;
import java.util.List;

@Named
@Dependent
public class PersonDao {
    @Inject
    EntityManager em;

    public List<Person> getAll() {
        return em.createQuery("select p from Person p order by p.lastName, p.firstName, p.matNr", Person.class).getResultList();
    }
    public Person save(@NotNull Person person) {
        return em.merge(person);
    }
    public Person get(int id) {
        return em.find(Person.class, id);
    }

    public void remove(Person person) {
        em.remove(person);
    }
}
