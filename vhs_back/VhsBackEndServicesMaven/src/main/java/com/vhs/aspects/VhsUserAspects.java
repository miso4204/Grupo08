/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.aspects;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

/**
 * Supported currency aspects definition.
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co)
 */
@Aspect
public class VhsUserAspects
{
    @Around("execution(@com.vhs.annotations.VHSFeature * com.vhs.service.VhsUserFacadeREST.edit(..))")
    public void adviceEdit(ProceedingJoinPoint pjp) throws Throwable
    {
        Logger.getLogger(VhsUserAspects.class.getName()).log(Level.INFO, "Feature interceptado: ChangePassword");
        Logger.getLogger(VhsUserAspects.class.getName()).log(Level.WARNING, "No se permite hacer cambio  de password");
    }
}
