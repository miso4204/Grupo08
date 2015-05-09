package com.vhs.annotations;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Feature IDE annotations
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co)
 */

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD) 
public @interface VHSFeature
{
    /**
     * Enumeration type
     */
    public enum Type 
    {
        OPTIONAL,
        MANDATORY
    }
    
    /**
     * @return annotation type
     */
    public Type type() default Type.MANDATORY;
   
    /**
     * @return feature name
     */
    public String name();
    
    /**
     * @return true if the feature is present in the family product. False otherwise.
     */
    public boolean featurePresent() default false;
}