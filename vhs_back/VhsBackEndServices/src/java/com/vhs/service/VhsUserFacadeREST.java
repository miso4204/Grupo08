/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.service;

import com.vhs.data.VhsUser;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.OPTIONS;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;

/**
 *
 * @author andresvargas
 */
@Stateless
@Path("vhsuser")
public class VhsUserFacadeREST extends AbstractFacade<VhsUser>
{

    @PersistenceContext(unitName = "VhsBackEndServicesPU")
    private EntityManager em;

    public VhsUserFacadeREST()
    {
        super(VhsUser.class);
    }

    @POST
    @Override
    @Consumes(
    {
        "application/xml", "application/json"
    })
    public void create(VhsUser entity)
    {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes(
    {
        "application/xml", "application/json"
    })
    public void edit(@PathParam("id") Integer id, VhsUser entity)
    {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id)
    {
        super.remove(super.find(id));
    }

    @GET
    @Path("{id}")
    @Produces(
    {
        "application/xml", "application/json"
    })
    public VhsUser find(@PathParam("id") Integer id)
    {
        return super.find(id);
    }

    @GET
    @Override
    @Produces(
    {
        "application/xml", "application/json"
    })
    public List<VhsUser> findAll()
    {
        return super.findAll();
    }

    @GET
    @Path("count")
    @Produces("text/plain")
    public String countREST()
    {
        return String.valueOf(super.count());
    }

    @GET
    @Path("{mail}/{pass}")
    @Produces(
    {
        "application/xml", "application/json"
    })
    public VhsUser userLogin(@PathParam("mail") String mail, @PathParam("pass") String pass)
    {

        Query q = em.createNamedQuery("VhsUser.findByLogin");
        q.setParameter("mail", mail);
        q.setParameter("password", pass);
        return (VhsUser) q.getSingleResult();
    }

    @Override
    protected EntityManager getEntityManager()
    {
        return em;
    }

    @OPTIONS
    public Response handleCORSRequest(@HeaderParam("Access-Control-Request-Method") final String requestMethod, @HeaderParam("Access-Control-Request-Headers") final String requestHeaders)
    {
        final ResponseBuilder retValue = Response.ok();
        if (requestHeaders != null)
        {
            retValue.header("Access-Control-Allow-Headers", requestHeaders);
        }

        if (requestMethod != null)
        {
            retValue.header("Access-Control-Allow-Methods", requestMethod);
        }
        return retValue.build();
    }
}
