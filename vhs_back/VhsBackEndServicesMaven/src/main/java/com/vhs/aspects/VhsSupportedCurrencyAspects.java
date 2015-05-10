/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.aspects;

import com.vhs.data.VhsSupportedCurrency;
import java.util.List;
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
public class VhsSupportedCurrencyAspects
{/*
    @Around("execution(* com.vhs.service.VhsSupportedCurrencyFacadeREST.findAll(..))")
    public Object adviceFindAll(ProceedingJoinPoint pjp) throws Throwable
    {
        List<VhsSupportedCurrency> currentResponse = (List<VhsSupportedCurrency>)pjp.proceed();
        
        for (VhsSupportedCurrency currentCurrency : currentResponse)
        {
            if (currentCurrency.getName().toLowerCase().contains("peso") || currentCurrency.getName().toLowerCase().contains("euro"))
            {
                currentResponse.remove(currentCurrency);
            }
        }
        
        return currentResponse;
    }*/
}
