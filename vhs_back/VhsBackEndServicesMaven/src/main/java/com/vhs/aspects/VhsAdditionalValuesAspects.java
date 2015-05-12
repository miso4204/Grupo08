/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.aspects;

import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

/**
 * Additional values aspects definition.
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co)
 */
@Aspect
public class VhsAdditionalValuesAspects
{
    @Around("execution(@com.vhs.annotations.VHSFeature * com.vhs.service.AdditionalValuesFacadeREST.findBySpecialOffer(..))")
    public Object adviceFindBySpecialOffer(ProceedingJoinPoint pjp) throws Throwable
    {
        Logger.getLogger(VhsAdditionalValuesAspects.class.getName()).log(Level.INFO, "Feature interceptado: ExtendedProductDescription");
        return new ArrayList<>();
    }
}
