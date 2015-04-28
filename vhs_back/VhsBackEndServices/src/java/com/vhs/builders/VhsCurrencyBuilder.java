/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.builders;

import com.vhs.data.VhsSupportedCurrency;
import com.vhs.data.VhsUser;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.Query;

/**
 *
 * @author andresvargas
 */
public class VhsCurrencyBuilder {

    /**
     *
     * @param em
     * @return
     */
    public List<VhsSupportedCurrency> prepareCurrency(EntityManager em) {
        VhsUser u = new VhsUser();

        Query q = em.createNamedQuery("VhsUser.findByFullName");
        q.setParameter("fullName", "admin");
        try {
            u = (VhsUser) q.getSingleResult();
        } catch (NoResultException nrs) {
            u = null;
        }
        if (u != null && u.getOptionalFeatureCurrencyManagement()) {
            return prepareBasicAndOpionalCurrency(em);
        } else {
            return prepareBasicCurrency(em);
        }

    }

    /**
     *
     * @param em
     * @return
     */
    private List<VhsSupportedCurrency> prepareBasicCurrency(EntityManager em) {
        Query q = em.createNamedQuery("VhsSupportedCurrency.findAllBasic");
        return (List<VhsSupportedCurrency>) q.getResultList();
    }

    /**
     *
     * @param em
     * @return
     */
    private List<VhsSupportedCurrency> prepareBasicAndOpionalCurrency(EntityManager em) {
        Query q = em.createNamedQuery("VhsSupportedCurrency.findAll");
        return (List<VhsSupportedCurrency>) q.getResultList();
    }

}
