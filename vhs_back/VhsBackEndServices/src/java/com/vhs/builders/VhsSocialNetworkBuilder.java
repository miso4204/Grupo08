/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.builders;

import com.vhs.builders.util.Utilities;
import com.vhs.data.VhsSocialNetwork;
import com.vhs.data.VhsSupportedCurrency;
import com.vhs.data.VhsUser;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 *
 * @author andresvargas
 */
public class VhsSocialNetworkBuilder {
    
    /**
     *
     * @param em
     * @return
     */
    public List<VhsSocialNetwork> prepare(EntityManager em) {
        VhsUser u = Utilities.getBaseUser(em);
        if (u != null && u.getOptionalFeatureSocialNetworks()) {
            return prepareBasicAndOptional(em);
        } else {
            return prepareBasic(em);
        }

    }
    
    /**
     *
     * @param em
     * @return
     */
    private List<VhsSocialNetwork> prepareBasic(EntityManager em) {
        Query q = em.createNamedQuery("VhsSocialNetwork.findAllBasic");
        return (List<VhsSocialNetwork>) q.getResultList();
    }
    
        /**
     *
     * @param em
     * @return
     */
    public  List<VhsSocialNetwork> prepareBasicAndOptional(EntityManager em) {
        Query q = em.createNamedQuery("VhsSocialNetwork.findAll");
        return (List<VhsSocialNetwork>) q.getResultList();
    }


    
}
