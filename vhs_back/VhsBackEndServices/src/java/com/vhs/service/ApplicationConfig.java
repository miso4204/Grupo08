/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.service;

import java.util.Set;
import javax.ws.rs.core.Application;

/**
 *
 * @author andresvargas
 */
@javax.ws.rs.ApplicationPath("webresources")
public class ApplicationConfig extends Application {

    @Override
    public Set<Class<?>> getClasses() {
        Set<Class<?>> resources = new java.util.HashSet<Class<?>>();
        addRestResourceClasses(resources);
        return resources;
    }

    /**
     * Do not modify addRestResourceClasses() method.
     * It is automatically populated with
     * all resources defined in the project.
     * If required, comment out calling this method in getClasses().
     */
    private void addRestResourceClasses(Set<Class<?>> resources) 
    {    
        resources.add(com.vhs.service.VhsCategoryFacadeREST.class);
        resources.add(com.vhs.service.VhsCityFacadeREST.class);
        resources.add(com.vhs.service.VhsCountryFacadeREST.class);
        resources.add(com.vhs.service.VhsOfferImageFacadeREST.class);
        resources.add(com.vhs.service.VhsOfferRatingFacadeREST.class);
        resources.add(com.vhs.service.VhsOfferSaleFacadeREST.class);
        resources.add(com.vhs.service.VhsPaymentMethodFacadeREST.class);
        resources.add(com.vhs.service.VhsSocialNetworkFacadeREST.class);
        resources.add(com.vhs.service.VhsSpecialOfferFacadeREST.class);
        resources.add(com.vhs.service.VhsSupportedCurrencyFacadeREST.class);
        resources.add(com.vhs.service.VhsUserFacadeREST.class);
    }
    
}
