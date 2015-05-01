/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.data;

import java.io.Serializable;
import java.util.List;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author andresvargas
 */
@XmlRootElement
public class DatosReporte implements Serializable {
    private String name;
    private Double data;
    
    
    /**
     * Default serial version UID
     */
    private static final long serialVersionUID = 1L;
    
    public DatosReporte()
    {
        
    }
    
    public DatosReporte(String name, Double data) {
        this.name = name;
        this.data = data;
    }
    

    public Double getData() {
        return data;
    }

    public void setData(Double data) {
        this.data = data;
    }
    

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }    
    
}
