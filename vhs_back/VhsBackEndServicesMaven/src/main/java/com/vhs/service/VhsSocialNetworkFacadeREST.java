/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.service;

import com.vhs.annotations.VHSFeature;
import com.vhs.builders.BuilderContract;
import com.vhs.builders.VhsSocialNetworkBuilder;
import com.vhs.data.VhsSocialNetwork;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
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
@Path("vhssocialnetwork")
public class VhsSocialNetworkFacadeREST extends AbstractFacade<VhsSocialNetwork> 
{
    private String getConcreteBuilder()
    {
        try
        {
            String className = this.getClass().getSimpleName();
            Context env = (Context)new InitialContext().lookup("java:comp/env");
            return (String)env.lookup("concreteBuilder" + className);
        } 
        catch (NamingException ex)
        {
            Logger.getLogger(VhsPaymentMethodFacadeREST.class.getName()).log(Level.SEVERE, "Error inicializando el constructor concreto", ex);
            return "com.vhs.builders.VhsPaymentMethodBuilder";
        }
    }
    
    @PersistenceContext(unitName = "VhsBackEndServicesPU")
    private EntityManager em;

    public VhsSocialNetworkFacadeREST() 
    {
        super(VhsSocialNetwork.class);
    }

    @POST
    @Override
    @Consumes({"application/xml", "application/json"})
    public void create(VhsSocialNetwork entity) 
    {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({"application/xml", "application/json"})
    public void edit(@PathParam("id") Long id, VhsSocialNetwork entity) 
    {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Long id) 
    {
        super.remove(super.find(id));
    }

    @GET
    @Path("{id}")
    @Produces({"application/xml", "application/json"})
    public VhsSocialNetwork find(@PathParam("id") Long id) 
    {
        return super.find(id);
    }

    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    @VHSFeature(featurePresent = false, name = "SocialNetworks", type = VHSFeature.Type.OPTIONAL)
    public List<VhsSocialNetwork> findAll() 
    {
        //BuilderContract builder = new VhsSocialNetworkBuilder();
        try
        {
            BuilderContract builder = (BuilderContract)Class.forName(getConcreteBuilder()).newInstance();
             return (List<VhsSocialNetwork>) builder.prepare(em);
        }
        catch (ClassNotFoundException | InstantiationException | IllegalAccessException e)
        {
            Logger.getLogger(VhsPaymentMethodFacadeREST.class.getName()).log(Level.SEVERE, "Error inicializando el constructor concreto", e);
            BuilderContract builder = new VhsSocialNetworkBuilder();
            return (List<VhsSocialNetwork>) builder.prepare(em);
        }
    }

    @GET
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<VhsSocialNetwork> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) 
    {
        return super.findRange(new int[]{from, to});
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
}
