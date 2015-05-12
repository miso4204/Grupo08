/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.service;

import com.vhs.data.VhsSpecialOffer;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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

/**
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 */
@Stateless
@Path("vhsspecialoffer")
public class VhsSpecialOfferFacadeREST extends AbstractFacade<VhsSpecialOffer> 
{
    @PersistenceContext(unitName = "VhsBackEndServicesPU")
    private EntityManager em;

    public VhsSpecialOfferFacadeREST() 
    {
        super(VhsSpecialOffer.class);
    }

    @POST
    @Override
    @Consumes({"application/xml", "application/json"})
    public void create(VhsSpecialOffer entity) 
    {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({"application/xml", "application/json"})
    public void edit(@PathParam("id") Integer id, VhsSpecialOffer entity) 
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
    @Produces({"application/xml", "application/json"})
    public VhsSpecialOffer find(@PathParam("id") Integer id) 
    {
        return super.find(id);
    }

    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    public List<VhsSpecialOffer> findAll() 
    {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<VhsSpecialOffer> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) 
    {
        return super.findRange(new int[]{from, to});
    }
    
    /**
     * 
     * @param from initial range
     * @param to final range
     * @return VhsSpecialOffer List
     */
    @GET
    @Path("price/{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<VhsSpecialOffer> findByRangePrice(@PathParam("from") Double from, @PathParam("to") Double to)
    {
         Query q = em.createNamedQuery("VhsSpecialOffer.findByRangePrice");
         q.setParameter("priceMin", from);
         q.setParameter("priceMax", to);
         return q.getResultList();
        
    }
    
    @GET
    @Path("user/{userId}")
    @Produces({"application/xml", "application/json"})
    public List<VhsSpecialOffer> findByUser(@PathParam("userId") Integer userId)
    {
         Query q = em.createNamedQuery("VhsSpecialOffer.findByUser");
         q.setParameter("userId", userId);
         return q.getResultList();
        
    }
    
    @GET
    @Path("special")
    @Produces({"application/xml", "application/json"})
    public List<VhsSpecialOffer> findByReallySpecialOffer()
    {
         Query q = em.createNamedQuery("VhsSpecialOffer.findAllReallySpecial");
         return q.getResultList();
    }
    
    /**
     * 
     * @param date date about the trip plan
     * @return VhsSpecialOffer List
     * @throws java.text.ParseException
     */
    @GET
    @Path("date/{date}")
    @Produces({"application/xml", "application/json"})
    public List<VhsSpecialOffer> findByRangeDate(@PathParam("date") String date) throws ParseException
    {
         Query q = em.createNamedQuery("VhsSpecialOffer.findByRangeDate");
         Calendar cdate = Calendar.getInstance();
         SimpleDateFormat sdf = new SimpleDateFormat("ddMMyyyy");
         cdate.setTime(sdf.parse(date));
         q.setParameter("date", cdate.getTime());
         return q.getResultList();
    }
    
    @GET
    @Path("city/{city}")
    @Produces({"application/xml", "application/json"})
    public List<VhsSpecialOffer> findByCityName(@PathParam("city") String cityName)
    {
         Query q = em.createNamedQuery("VhsSpecialOffer.findByCity");
         q.setParameter("cityName", cityName);
         return q.getResultList();
    }
    
    @GET
    @Path("count")
    @Produces("text/plain")
    public String countREST() 
    {
        return String.valueOf(super.count());
    }

    @Override
    protected EntityManager getEntityManager() 
    {
        return em;
    }
    
    @OPTIONS
    public Response handleCORSRequest(@HeaderParam("Access-Control-Request-Method") final String requestMethod, @HeaderParam("Access-Control-Request-Headers") final String requestHeaders)
    {
        final Response.ResponseBuilder retValue = Response.ok();
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
