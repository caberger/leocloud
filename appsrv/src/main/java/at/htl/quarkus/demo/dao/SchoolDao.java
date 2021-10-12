package at.htl.quarkus.demo.dao;

import at.htl.quarkus.demo.model.School;

import javax.enterprise.context.Dependent;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import java.util.List;

@Dependent
public class SchoolDao {
    @Inject
    EntityManager em;
    public List<School> all() {
        return em.createQuery("select s from School s", School.class).getResultList();
    }

    public School findById(int id) {
        return em.find(School.class, id);
    }
}
