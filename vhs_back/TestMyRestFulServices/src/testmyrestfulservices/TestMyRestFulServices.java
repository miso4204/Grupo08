/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package testmyrestfulservices;

import com.vhs.data.VhsUser;
import com.vhs.services.client.NewJerseyClient;

/**
 *
 * @author andresvargas
 */
public class TestMyRestFulServices {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
         testCreateUser();
    }
    
    public static void testCreateUser(){
         NewJerseyClient client = new NewJerseyClient();
         VhsUser u= new VhsUser();
         u.setFullName("Prueba Seis");
         u.setMail("prueba6@gmail.com");
         u.setPassword("prueba6");
         u.setUserKind("Provider");
         client.create_JSON(u);
         // do whatever with response
         client.close();
    }
    
}
