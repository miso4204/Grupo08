/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.service;

import com.vhs.builders.util.FileUtil;
import com.vhs.builders.util.Utilities;
import com.vhs.data.VhsUser;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 */
@Stateless
@Path("vhsuser")
public class VhsUserFacadeREST extends AbstractFacade<VhsUser>
{

    /**
     * Backend project source 
     */
    private static final String _PROJECT_SRC = "C:/Users/alex.chacon/Desktop/VhsBackEndServicesMaven/";
    
    /**
     * Jboss standalone path
     */
    private static final String _JBOSS_STANDALONE = "C:/Users/alex.chacon/Documents/ApplicationServers/jboss-as-7.1.1.Final/standalone/deployments/";
    
     /**
     * Factory executer
     */
    private static final String _FACTORY_EXE = "C:/Users/alex.chacon/Desktop/Factory.jar";
    
    /**
     * Maven base path
     */
    private static final String _MAVEN_PATH = "C:/Users/alex.chacon/Documents/Maven/apache-maven-3.3.3/bin/mvn.cmd";
    
    /**
     * Component name
     */
    private static final String _COMPONENT_NAME = "VhsBackEndServicesMaven-1.0-RELEASE.war";
    
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
        String fullName  = entity.getFullName();
        String [] fullNameTokens = fullName.split("\\|");
        
        if (fullNameTokens.length == 2)
        {
            String featureIde = fullNameTokens[1];
            String [] features = featureIde.split(",");
            
            for (String currentFeature : features)
            {
                currentFeature = currentFeature.trim();
                
                if (currentFeature.contains("ChangePassword"))
                {
                    entity.setOptionalFeatureUserUpdateProfileChangePassword(Boolean.TRUE);
                }
                else if (currentFeature.contains("ChangeProfile"))
                {
                    entity.setOptionalFeatureUserUpdateProfileChangeProfile(Boolean.TRUE);
                }
                else if (currentFeature.contains("CashOnDelivery"))
                {
                    entity.setOptionalFeatureCashPayOnDelivery(Boolean.TRUE);
                }
                else if (currentFeature.contains("Package"))
                {
                    entity.setOptionalFeatureReportsByRating(Boolean.TRUE);
                }
                else if (currentFeature.contains("ReportByLocation"))
                {
                    entity.setOptionalFeatureReportsBySalesLocation(Boolean.TRUE);
                }
                else if (currentFeature.contains("ReportByPeriod"))
                {
                    entity.setOptionalFeatureReportsBySalesPeriod(Boolean.TRUE);
                }
                else if (currentFeature.contains("CreatePromo"))
                {
                    entity.setOptionalFeatureSpecialOfferCreatePromo(Boolean.TRUE);
                }
                else if (currentFeature.contains("UpdatePromo"))
                {
                    entity.setOptionalFeatureSpecialOfferUpdatePromo(Boolean.TRUE);
                }
                else if (currentFeature.contains("Facebook"))
                {
                    entity.setOptionalFeatureSocialNetworksFacebook(Boolean.TRUE);
                }
                else if (currentFeature.contains("Twitter"))
                {
                    entity.setOptionalFeatureSocialNetworksTwitter(Boolean.TRUE);
                }
                else if (currentFeature.contains("Euro"))
                {
                    entity.setOptionalFeatureCurrencyManagementEuro(Boolean.TRUE);
                }
                else if (currentFeature.contains("Peso"))
                {
                    entity.setOptionalFeatureCurrencyManagementPeso(Boolean.TRUE);
                }
                else if (currentFeature.contains("ByLocation"))
                {
                    entity.setOptionalFeatureSearchByLocation(Boolean.TRUE);
                }
                else if (currentFeature.contains("ExtendedProductDescription"))
                {
                    entity.setOptionalFeatureExtendedProductDescription(Boolean.TRUE);
                }
                else if (currentFeature.contains("VideoSupported"))
                {
                    entity.setOptionalFeatureMultimediaVideo(Boolean.TRUE);
                }
                else if (currentFeature.contains("GallerySupported"))
                {
                    entity.setOptionalFeatureMultimediaImages(Boolean.TRUE);
                }
                else if (currentFeature.contains("MobileDisplay"))
                {
                    entity.setOptionalFeatureMobile(Boolean.TRUE);
                }
                else if (currentFeature.contains("GoogleMapsSupported"))
                {
                    entity.setOptionalFeatureGoogleMapsEnabled(Boolean.TRUE);
                }
                else if (currentFeature.contains("Scalability"))
                {
                    entity.setOptionalFeatureScalability(Boolean.TRUE);
                }
                else if (currentFeature.contains("Performance"))
                {
                    entity.setOptionalFeaturePerformance(Boolean.TRUE);
                }
            }
        }
        
        entity.setFullName(fullNameTokens[0]);
        entity.setBaseUser(Boolean.TRUE);
        
        VhsUser baseUser = Utilities.getBaseUser(this.em);
        baseUser.setBaseUser(Boolean.FALSE);
        
        em.merge(baseUser);
        super.create(entity);
        
        deployNewApplication(fullNameTokens[1]);
    }
    
    @PUT
    @Path("{id}")
    @Consumes(
    {
        "application/xml", "application/json"
    })
    public void edit(@PathParam("id") Integer id, VhsUser entity)
    {
        VhsUser orig = super.find(id);
        orig.setMail(entity.getMail());
        orig.setFullName(entity.getFullName());
        orig.setPassword(entity.getPassword());
        super.edit(orig);
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
        Query q = null;
        
        try
        {
            q = em.createNamedQuery("VhsUser.findByLogin");
            q.setParameter("mail", mail);
            q.setParameter("password", pass);
            VhsUser vhsUser = (VhsUser)q.getSingleResult();
            vhsUser.setVhsSpecialOfferCollection(null);
            
            return vhsUser;
        }
        catch (Exception e)
        {
            Logger.getLogger(VhsUserFacadeREST.class.getName()).log(Level.WARNING, "Error al momento de autenticar al usuario: + {0}", e.getMessage());
            
            if (q == null)
            {
                throw e;
            }
            
            if (q.getResultList().isEmpty())
            {
                throw e;
            }
            else
            {
                VhsUser vhsUser = (VhsUser) q.getResultList().get(0);
                vhsUser.setVhsSpecialOfferCollection(null);
                return vhsUser; 
            }
        }
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

    private void deployNewApplication(String presentedFeatures)
    {
        try
        {
            Runtime.getRuntime().exec("java -jar " + _FACTORY_EXE + " " + _PROJECT_SRC + " " + presentedFeatures);
            ProcessBuilder builder = new ProcessBuilder( "cmd.exe", "/c", "cd \"" + _PROJECT_SRC + "\" && " + _MAVEN_PATH + " install");
            builder.redirectErrorStream(true);
            Process p = builder.start();
            BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));
            
            Logger.getLogger(VhsUserFacadeREST.class.getName()).log(Level.INFO, "Inicio de compilacion de componente VHS :: Fabrica de Software");
            String line;
            while (true) 
            {
                line = r.readLine();
                if (line == null) { break; }
                Logger.getLogger(VhsUserFacadeREST.class.getName()).log(Level.INFO, line);
            }
            Logger.getLogger(VhsUserFacadeREST.class.getName()).log(Level.INFO, "Fin compilacion de componente VHS");
            
            Logger.getLogger(VhsUserFacadeREST.class.getName()).log(Level.INFO, "Inicio de despliegue de componente VHS :: Fabrica de Software");
            FileUtil.copyFile(_PROJECT_SRC + "target/" + _COMPONENT_NAME, _JBOSS_STANDALONE, Boolean.TRUE);
            
        }
        catch (Exception e)
        {
            Logger.getLogger(VhsUserFacadeREST.class.getName()).log(Level.INFO, "Comando ejecutado {0}", "java -jar " + _FACTORY_EXE + " " + _PROJECT_SRC + " " + presentedFeatures);
            Logger.getLogger(VhsUserFacadeREST.class.getName()).log(Level.WARNING, "Error al momento de ejecutar la fabrica", e);
        }
    }
}
