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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Available service image
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co) 
 */
@Entity
@XmlRootElement
public class VhsOfferImage implements Serializable
{
    /**
     * Default serial version UID
     */
    private static final long serialVersionUID = 1L;
    
    /**
     * Image identifier
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    /**
     * Image absolute URL
     */
    @Column(name = "url")
    private String url;
    
    /**
     * Image footer
     */
    @Column(name = "footer")
    private String footer;
    
    /**
     * Associated special offer
     */
    @JoinColumn(name = "special_offer", referencedColumnName = "id_special_offers")
    @ManyToOne
    private VhsSpecialOffer specialOffer;
    
    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public String getUrl()
    {
        return url;
    }

    public void setUrl(String url)
    {
        this.url = url;
    }

    public String getFooter()
    {
        return footer;
    }

    public void setFooter(String footer)
    {
        this.footer = footer;
    }

    public VhsSpecialOffer getSpecialOffer()
    {
        return specialOffer;
    }

    public void setSpecialOffer(VhsSpecialOffer specialOffer)
    {
        this.specialOffer = specialOffer;
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
        if (!(object instanceof VhsOfferImage))
        {
            return false;
        }
        VhsOfferImage other = (VhsOfferImage) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id)))
        {
            return false;
        }
        return true;
    }

    @Override
    public String toString()
    {
        return "com.vhs.data.VhsOfferImage[ id=" + id + " ]";
    }
    
}
