package at.htl.quarkus.demo.rest;

import at.htl.quarkus.demo.dao.PersonDao;
import at.htl.quarkus.demo.model.Person;

import javax.inject.Inject;
import javax.transaction.Transactional;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.StreamingOutput;
import java.io.*;
import java.util.List;

@Path("person")
@Produces(MediaType.APPLICATION_JSON)
@Transactional
public class PersonResource {
    @Inject
    PersonDao personDao;

    @GET
    public List<Person> all() {
        assert personDao != null;

        var persons = personDao.getAll();

        return persons;
    }
    @GET
    @Path("{id}")
    public Person getPerson(@PathParam("id") int id) {
        return personDao.get(id);
    }
    @PUT
    public Response addPerson(Person person) {
        personDao.save(person);
        return Response.ok(person).status(Response.Status.CREATED).build();
    }
    @DELETE
    @Path("{id}")
    public Response delete(@PathParam("id") int id) {
        var person = personDao.get(id);
        personDao.remove(person);
        return Response.status(Response.Status.NO_CONTENT).build();
    }
    @GET
    @Path("download")
    @Produces(MediaType.TEXT_PLAIN)
    public Response downloadAllPersons() {
        var persons = personDao.getAll();
        var output = new StreamingOutput() {
            @Override
            public void write(OutputStream outputStream) {
                try (var writer = new PrintWriter(outputStream)) {
                    persons.stream().forEach(writer::println);
                }
            }
        };
        return Response.ok(output).header("Content-Disposition", "attachment; filename=\"persons.txt\"").build();
    }
}
