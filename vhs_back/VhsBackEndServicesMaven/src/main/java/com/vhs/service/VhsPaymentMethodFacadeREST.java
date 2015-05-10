/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.service;

import com.vhs.annotations.VHSFeature;
import com.vhs.builders.BuilderContract;
import com.vhs.builders.VhsPaymentMethodBuilder;
import com.vhs.builders.VhsSocialNetworkBuilder;
import com.vhs.data.VhsPaymentMethod;
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
@Path("vhspaymentmethod")
public class VhsPaymentMethodFacadeREST extends AbstractFacade<VhsPaymentMethod> 
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

    public VhsPaymentMethodFacadeREST()
    {
        super(VhsPaymentMethod.class);
    }

    @POST
    @Override
    @Consumes({"application/xml", "application/json"})
    public void create(VhsPaymentMethod entity) 
    {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({"application/xml", "application/json"})
    public void edit(@PathParam("id") Long id, VhsPaymentMethod entity) 
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
    public VhsPaymentMethod find(@PathParam("id") Long id) 
    {
        return super.find(id);
    }

    @GET
    @Override
    @Produces({"application/xml", "application/json"})
    @VHSFeature(featurePresent = false, name = "Pay", type = VHSFeature.Type.OPTIONAL)
    public List<VhsPaymentMethod> findAll() 
    {
        //BuilderContract builder = new VhsPaymentMethodBuilder();
        try
        {
            BuilderContract builder = (BuilderContract)Class.forName(getConcreteBuilder()).newInstance();
            return (List<VhsPaymentMethod>)builder.prepare(em);
        }
        catch (ClassNotFoundException | InstantiationException | IllegalAccessException e)
        {
            Logger.getLogger(VhsPaymentMethodFacadeREST.class.getName()).log(Level.SEVERE, "Error inicializando el constructor concreto", e);
            BuilderContract builder = new VhsPaymentMethodBuilder();
            return (List<VhsPaymentMethod>)builder.prepare(em);
        }
        
    }

    @GET
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<VhsPaymentMethod> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) 
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
