/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.builders.util;

import com.vhs.data.VhsUser;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author andresvargas
 */
public class Utilities 
{    
    @PersistenceContext(unitName = "VhsBackEndServicesPU")
    
    public static VhsUser getBaseUser(EntityManager em)
    {
        Query query = em.createNamedQuery("VhsUser.findActiveUser");
        try
        {
            VhsUser currentUser = (VhsUser) query.getSingleResult();
            Logger.getLogger(Utilities.class.getName()).log(Level.INFO, "Current user({0}): {1}", new Object[]{currentUser.getUserId(), currentUser.getFullName()});
            return currentUser;
        }
        catch (Exception e)
        {
            Logger.getLogger(Utilities.class.getName()).log(Level.WARNING, "There is not active users: ({0})", new Object[]{e.getMessage()});
            query = em.createNamedQuery("VhsUser.findLastUsers");
            List<VhsUser> currentResult = (List<VhsUser>)query.getResultList();
            
            if (currentResult.isEmpty())
            {
                Logger.getLogger(Utilities.class.getName()).log(Level.WARNING, "There is not users registrered in the data base. NULL is returned as a active user.");
                return null;
            }
            else
            {
                VhsUser currentUser = currentResult.get(0);
                Logger.getLogger(Utilities.class.getName()).log(Level.INFO, "Current user({0}): {1}", new Object[]{currentUser.getUserId(), currentUser.getFullName()});
            
                return currentUser;
            }
        }
    }   
}