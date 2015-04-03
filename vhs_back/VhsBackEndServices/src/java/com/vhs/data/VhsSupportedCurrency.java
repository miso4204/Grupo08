/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.data;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * Available currencies entity
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co) 
 */
@Entity 
public class VhsSupportedCurrency implements Serializable
{
    /**
     * Default serial version UID
     */
    private static final long serialVersionUID = 1L;
    
    /**
     * Currency identifier
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    /**
     * Currency name
     */
    @Column(name = "name")
    private String name;
    
    /**
     *  Optional flag. If true this currency will not available in some products (i.e. Euro or Colombian Pesos).
     */
    @Column(name = "optional")
    private Boolean optional;
    
    /**
     * Dollas change rate: 2.850 for colombian Pesos and 0.98 for Euro
     */
    @Column(name = "dollar_change_rate")
    private Double dollarChangeRate;
    
    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public Boolean getOptional()
    {
        return optional;
    }

    public void setOptional(Boolean optional)
    {
        this.optional = optional;
    }

    public Double getDollarChangeRate()
    {
        return dollarChangeRate;
    }

    public void setDollarChangeRate(Double dollarChangeRate)
    {
        this.dollarChangeRate = dollarChangeRate;
    }

    @Override
    public int hashCode()
    {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object)
    {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof VhsSupportedCurrency))
        {
            return false;
        }
        VhsSupportedCurrency other = (VhsSupportedCurrency) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id)))
        {
            return false;
        }
        return true;
    }

    @Override
    public String toString()
    {
        return "com.vhs.data.VhsSupportedCurrency[ id=" + id + " ]";
    }
    
}
