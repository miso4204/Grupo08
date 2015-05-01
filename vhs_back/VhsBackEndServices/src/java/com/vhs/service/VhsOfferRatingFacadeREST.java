/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.service;

import com.vhs.data.DatosReporte;
import com.vhs.data.VhsCountry;
import com.vhs.data.VhsOfferRating;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
 * @author andresvargas
 */
@Stateless
@Path("vhsofferrating")
public class VhsOfferRatingFacadeREST extends AbstractFacade<VhsOfferRating> {
    @PersistenceContext(unitName = "VhsBackEndServicesPU")
    private EntityManager em;

    public VhsOfferRatingFacadeREST() {
        super(VhsOfferRating.class);
    }

    @POST
    @Override
    @Consumes({"application/xml", "application/json"})
    public void create(VhsOfferRating entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({"application/xml", "application/json"})
    public void edit(@PathParam("id") Long id, VhsOfferRating entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Long id) {
        super.remove(super.find(id));
    }

    @GET
    @Path("{id}")
    @Produces({"application/xml", "application/json"})
    public VhsOfferRating find(@PathParam("id") Long id) {
        return super.find(id);
    }

    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    public List<VhsOfferRating> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<VhsOfferRating> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }
    
    /**
     * 
     * @param mail
     * @param begin final date format ddmmaaaa
     * @param end final date format ddmmaaaa
     * @param type tipo de reporte location or package
     * @throws ParseException
     * @return 
     */
    @GET
    @Path("{mail}/{begin}/{end}/{type}")
    @Produces({"application/xml", "application/json"})
    public List<DatosReporte> findRating(@PathParam("mail") String mail, @PathParam("begin") String begin, @PathParam("end") String end,  @PathParam("type") String type )  throws ParseException{
        Query q;
        if(type.equalsIgnoreCase("location"))
        {
            q = getEntityManager().createNativeQuery(VhsOfferRating.SQL_RATING_LOCATION);
        }
        else
        {
            q = getEntityManager().createNativeQuery(VhsOfferRating.SQL_RATING_PRODUCT);
        }
        return getReport(q, mail, begin, end );
        
     }

    @GET
    @Path("count")
    @Produces("text/plain")
    public String countREST() {
        return String.valueOf(super.count());
    }

    @Override
    protected EntityManager getEntityManager() {
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
