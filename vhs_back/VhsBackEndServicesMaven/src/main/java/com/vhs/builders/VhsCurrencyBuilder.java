/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.builders;

import com.vhs.builders.util.Utilities;
import com.vhs.data.VhsSupportedCurrency;
import com.vhs.data.VhsUser;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 */
public class VhsCurrencyBuilder implements BuilderContract
{
    
    /**
     *
     * @param em entity manager
     * @return supported currencies according with the client
     */
    @Override
    public List<VhsSupportedCurrency> prepare(EntityManager em) 
    {
        VhsUser u = Utilities.getBaseUser(em);
        List<VhsSupportedCurrency> supportedCurrencies = prepareBasic(em);
        
        if (u == null)
        {
            return supportedCurrencies;
        }
        
        for (VhsSupportedCurrency currentCurrency : supportedCurrencies)
        {
            if (currentCurrency.getName().toLowerCase().contains("peso") && !u.getOptionalFeatureCurrencyManagementPeso())
            {
                supportedCurrencies.remove(currentCurrency);
            }
            if (currentCurrency.getName().toLowerCase().contains("euro") && !u.getOptionalFeatureCurrencyManagementEuro())
            {
                supportedCurrencies.remove(currentCurrency);
            }
        }
        return supportedCurrencies;
    }
    
    /**
     *
     * @param em entity manager
     * @return all mandatory currencies
     */
    private List<VhsSupportedCurrency> prepareBasic(EntityManager em) 
    {
        Query q = em.createNamedQuery("VhsSupportedCurrency.findAll");
        return (List<VhsSupportedCurrency>) q.getResultList();
    }
}
