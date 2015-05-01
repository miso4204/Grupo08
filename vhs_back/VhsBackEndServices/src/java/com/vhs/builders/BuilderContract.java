/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.builders;

import java.util.List;
import javax.persistence.EntityManager;

/**
 *
 * @author andresvargas
 */
public interface BuilderContract {
    
    /**
     *
     * @param em
     * @return
     */
    List prepare(EntityManager em);

    /**
     *
     * @param em
     * @return
     */
    List prepareBasic(EntityManager em);

    /**
     *
     * @param em
     * @return
     */
    List prepareBasicAndOptional(EntityManager em);
    
}
