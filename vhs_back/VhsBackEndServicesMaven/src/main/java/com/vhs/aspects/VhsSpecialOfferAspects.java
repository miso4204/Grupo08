/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.aspects;

import com.vhs.data.AdditionalValues;
import com.vhs.data.VhsSpecialOffer;
import com.vhs.service.VhsPaymentMethodFacadeREST;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

/**
 * Spacial offer aspects definition.
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co)
 */
@Aspect
public class VhsSpecialOfferAspects
{
    @Around("execution(* com.vhs.service.VhsSpecialOfferFacadeREST.findAll(..))")
    public Object adviceFindAll(ProceedingJoinPoint pjp) throws Throwable
    {
        
        
        
        List<VhsSpecialOffer> currentResponse = (List<VhsSpecialOffer>)pjp.proceed();
        List<AdditionalValues> additionalValue = new ArrayList<>();
        
        for(VhsSpecialOffer currentOffer : currentResponse)
        {
             Logger.getLogger(VhsSpecialOfferAspects.class.getName()).log(Level.INFO, "Ingreso....");
            AdditionalValues additionalValue1 = new AdditionalValues();
            additionalValue1.setId(new Long(1));
            additionalValue1.setCurrentValue("Value1");
            additionalValue1.setTitle("Title1");

            AdditionalValues additionalValue2 = new AdditionalValues();
            additionalValue2.setId(new Long(2));
            additionalValue2.setCurrentValue("Value2");
            additionalValue2.setTitle("Title2");
                
            additionalValue1.setSpecialOffer(currentOffer);
            additionalValue2.setSpecialOffer(currentOffer);
            
            additionalValue.add(additionalValue1);
            additionalValue.add(additionalValue2);
            
            currentOffer.setAdditionalValues(additionalValue);
            
        }
        Logger.getLogger(VhsSpecialOfferAspects.class.getName()).log(Level.INFO, "Ingreso....{0}", currentResponse);
        return currentResponse;
    }
}
