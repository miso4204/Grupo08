/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.builders;

import com.vhs.builders.util.Utilities;
import com.vhs.data.VhsPaymentMethod;
import com.vhs.data.VhsSocialNetwork;
import com.vhs.data.VhsUser;
import java.util.Iterator;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 */
public class VhsSocialNetworkBuilder implements BuilderContract
{
    
    /**
     *
     * @param em entity manager
     * @return current builders
     */
    @Override
    public List<VhsSocialNetwork> prepare(EntityManager em) 
    {
        VhsUser u = Utilities.getBaseUser(em);
        List<VhsSocialNetwork> supportedNetworks = prepareBasic(em);
        
        if (u == null)
        {
            return supportedNetworks;
        }
        
        boolean optionFace = (u.getOptionalFeatureSocialNetworksFacebook() != null)?(u.getOptionalFeatureSocialNetworksFacebook()):(false);
        boolean optionTwitter = (u.getOptionalFeatureSocialNetworksTwitter() != null)?(u.getOptionalFeatureSocialNetworksTwitter()):(false);
        
        for (Iterator<VhsSocialNetwork> iter = supportedNetworks.listIterator(); iter.hasNext(); ) 
        {
            VhsSocialNetwork currentNetwork = iter.next();
            
            if (currentNetwork.getName().toLowerCase().contains("facebook") && !optionFace)
            {
                iter.remove();
            }
            if (currentNetwork.getName().toLowerCase().contains("twitter") && !optionTwitter)
            {
                iter.remove();
            }
        }
        return supportedNetworks;
    }
    
    /**
     *
     * @param em entity manager
     * @return filtered elements
     */
    private List<VhsSocialNetwork> prepareBasic(EntityManager em) 
    {
        Query q = em.createNamedQuery("VhsSocialNetwork.findAll");
        return (List<VhsSocialNetwork>) q.getResultList();
    }
}
