package at.htl.quarkus.demo.rest;

import at.htl.quarkus.demo.dao.BillDao;
import at.htl.quarkus.demo.model.Bill;

import javax.inject.Inject;
import javax.transaction.Transactional;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

@Transactional
@Produces(MediaType.APPLICATION_JSON)
@Path("bill")
public class BillResource {
    @Inject
    BillDao dao;

    @GET
    public List<Bill> all() {
        return dao.getAll();
    }

    @GET
    @Path("{id}")
    public Bill getBill(@PathParam("id") int id) {
        return dao.get(id);
    }

    @PUT
    public Response addBill(Bill bill) {
        var lines = bill.getLines();
        bill.setLines(null);
        dao.insert(bill);
        var id = 1;
        for (var l: lines) {
            l.getLinePk().setBillId(bill.getBill_id());
            l.getLinePk().setRow_id(id++);
        }
        bill.setLines(lines);
        dao.save(bill);
        return Response.ok(bill).status(Response.Status.CREATED).build();
    }
    @DELETE
    @Path("{id}")
    public Response delete(@PathParam("id") int id) {
        var bill = dao.get(id);
        dao.delete(bill);
        return Response.status(Response.Status.NO_CONTENT).build();
    }
}
