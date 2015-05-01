/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.builders.util;

import com.vhs.data.VhsUser;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author andresvargas
 */
public class Utilities {
    
    @PersistenceContext(unitName = "VhsBackEndServicesPU")
    
    public static VhsUser getBaseUser(EntityManager em)
    {
        VhsUser u = new VhsUser();

        Query q = em.createNamedQuery("VhsUser.findByFullName");
        q.setParameter("fullName", "admin");
        try {
            u = (VhsUser) q.getSingleResult();
        } catch (NoResultException nrs) {
            u = null;
        }
        return u;
    }
    
}
