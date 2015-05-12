/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.aspects;

import com.vhs.data.AdditionalValues;
import com.vhs.data.VhsSpecialOffer;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

/**
 * User aspects definition.
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co)
 */
@Aspect
public class VhsUserAspects
{
    @Around("execution(* com.vhs.service.VhsUserFacadeREST.create(..))")
    public void adviceCreate(ProceedingJoinPoint pjp) throws Throwable
    {
        //pjp.getArgs()[0]
        pjp.proceed();
    }
}
