package com.vhs.aspects;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

@Aspect
/**
 * First test aspect definition.
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co)
 */
public class TestAspect
{

    private String message;

    public void setMessage(String message)
    {
        this.message = message;
    }

    @Around("execution(* com.vhs.aspects.test.services.TestService.*(..))")
    public Object advice(ProceedingJoinPoint pjp) throws Throwable
    {
        String serviceGreeting = (String) pjp.proceed();
        return message + " and " + serviceGreeting;
    }
    
    @Around("execution(* com.vhs.service.VhsUserFacadeREST.countREST(..))")
    public Object adviceUserCount(ProceedingJoinPoint pjp) throws Throwable
    {
        String count = (String) pjp.proceed();
        return "Count intercepted" + " and " + count;
    }
}