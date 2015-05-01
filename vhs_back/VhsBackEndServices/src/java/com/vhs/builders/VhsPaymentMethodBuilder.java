/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.builders;

import com.vhs.builders.util.Utilities;
import com.vhs.data.VhsPaymentMethod;
import com.vhs.data.VhsSupportedCurrency;
import com.vhs.data.VhsUser;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 *
 * @author andresvargas
 */
public class VhsPaymentMethodBuilder {
    
    /**
     *
     * @param em
     * @return
     */
    public List<VhsPaymentMethod> prepare(EntityManager em) {
        VhsUser u = Utilities.getBaseUser(em);
        if (u != null && u.getOptionalFeatureCashPayOnDelivery()) {
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
    private List<VhsPaymentMethod> prepareBasic(EntityManager em) {
        Query q = em.createNamedQuery("VhsPaymentMethod.findAllBasic");
        return (List<VhsPaymentMethod>) q.getResultList();
    }

    /**
     *
     * @param em
     * @return
     */
    private List<VhsPaymentMethod> prepareBasicAndOptional(EntityManager em) {
        Query q = em.createNamedQuery("VhsPaymentMethod.findAll");
        return (List<VhsPaymentMethod>) q.getResultList();
    }
    
}
