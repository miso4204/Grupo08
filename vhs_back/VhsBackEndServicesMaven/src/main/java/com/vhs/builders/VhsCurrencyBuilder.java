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
 * @author andresvargas
 */
public class VhsCurrencyBuilder implements BuilderContract{

    /**
     *
     * @param em
     * @return
     */
    public List<VhsSupportedCurrency> prepare(EntityManager em) {
        VhsUser u = Utilities.getBaseUser(em);
        if (u != null && u.getOptionalFeatureCurrencyManagement()) {
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
    public List<VhsSupportedCurrency> prepareBasic(EntityManager em) {
        Query q = em.createNamedQuery("VhsSupportedCurrency.findAllBasic");
        return (List<VhsSupportedCurrency>) q.getResultList();
    }

    /**
     *
     * @param em
     * @return
     */
    public  List<VhsSupportedCurrency> prepareBasicAndOptional(EntityManager em) {
        Query q = em.createNamedQuery("VhsSupportedCurrency.findAll");
        return (List<VhsSupportedCurrency>) q.getResultList();
    }

}
