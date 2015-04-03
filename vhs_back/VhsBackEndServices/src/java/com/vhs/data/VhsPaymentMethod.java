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
 * Available payment method entity
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co)
 */
@Entity
public class VhsPaymentMethod implements Serializable
{
    /**
     * Default serial version UID
     */
    private static final long serialVersionUID = 1L;
    
     /**
     * Payment method identifier
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_payment")
    private Long id;

    /**
     * Payment method name
     */
    @Column(name = "name")
    private String name;
    
    /**
     * Optional flag. If true this payment method will not available in some products (i.e. Cash payment method).
     */
    @Column(name = "optional")
    private Boolean optional;
    
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
        if (!(object instanceof VhsPaymentMethod))
        {
            return false;
        }
        VhsPaymentMethod other = (VhsPaymentMethod) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id)))
        {
            return false;
        }
        return true;
    }

    @Override
    public String toString()
    {
        return "com.vhs.data.VhsPaymentMethod[ id=" + id + " ]";
    }
    
}
