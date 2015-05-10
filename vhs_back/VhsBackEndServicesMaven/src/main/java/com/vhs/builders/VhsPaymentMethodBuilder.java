/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.builders;

import com.vhs.builders.util.Utilities;
import com.vhs.data.VhsPaymentMethod;
import com.vhs.data.VhsUser;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 */
public class VhsPaymentMethodBuilder implements BuilderContract
{
    
    /**
     *
     * @param em entity manager
     * @return current builders
     */
    @Override
    public List<VhsPaymentMethod> prepare(EntityManager em) 
    {
        VhsUser u = Utilities.getBaseUser(em);
        List<VhsPaymentMethod> supportedPayments = prepareBasic(em);
        
        if (u == null)
        {
            return supportedPayments;
        }
        
        for (VhsPaymentMethod currentPayment : supportedPayments)
        {
            if (currentPayment.getName().toLowerCase().contains("cash") && !u.getOptionalFeatureCashPayOnDelivery())
            {
                supportedPayments.remove(currentPayment);
            }
        }
        return supportedPayments;
    }
    
    /**
     *
     * @param em entity manager
     * @return filtered elements
     */
    private List<VhsPaymentMethod> prepareBasic(EntityManager em) 
    {
        Query q = em.createNamedQuery("VhsPaymentMethod.findAll");
        return (List<VhsPaymentMethod>) q.getResultList();
    }
}
