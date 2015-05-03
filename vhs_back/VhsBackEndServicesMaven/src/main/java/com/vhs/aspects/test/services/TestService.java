/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.aspects.test.services;

import org.springframework.stereotype.Service;

@Service("testService")
/**
 * Service to be intercepted by the aspect.
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co)
 */
public class TestService
{

    public String sayHello()
    {
        return "Hello from test service";
    }
}