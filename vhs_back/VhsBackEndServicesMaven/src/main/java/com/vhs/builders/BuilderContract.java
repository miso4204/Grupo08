/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.builders;

import java.util.List;
import javax.persistence.EntityManager;

/**
 * Builder contrar pattern
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 */
public interface BuilderContract 
{
    /**
     *
     * @param em entity manager
     * @return list of objects filtered according the product features
     */
    public List<?> prepare(EntityManager em);
}
