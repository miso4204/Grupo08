/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.service;

import com.vhs.data.AdditionalValues;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

/**
 *
 * @author ivanfgarcias
 */
@Stateless
@Path("vhsadditionalvalues")
public class AdditionalValuesFacadeREST extends AbstractFacade<AdditionalValues> {
    @PersistenceContext(unitName = "VhsBackEndServicesPU")
    private EntityManager em;

    public AdditionalValuesFacadeREST() {
        super(AdditionalValues.class);
    }

    @POST
    @Override
    @Consumes({"application/xml", "application/json"})
    public void create(AdditionalValues entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({"application/xml", "application/json"})
    public void edit(@PathParam("id") Long id, AdditionalValues entity) {
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
    public AdditionalValues find(@PathParam("id") Long id) {
        return super.find(id);
    }
    
    @GET
    @Path("specialoffer/{idSpecialOffers}")
    @Produces({"application/xml", "application/json"})
    public List<AdditionalValues> findBySpecialOffer(@PathParam("idSpecialOffers") Integer idSpecialOffers) {
        Query q = em.createNamedQuery("VhsAdditionalValues.findBySpecialOffer");
        q.setParameter("idSpecialOffers", idSpecialOffers);
        return (List<AdditionalValues>) q.getResultList();
    }

    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    public List<AdditionalValues> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<AdditionalValues> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
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
    
}
