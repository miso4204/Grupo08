/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.data;

import java.io.Serializable;
<<<<<<< HEAD
import java.util.Collection;
import javax.persistence.Basic;
=======
>>>>>>> origin/develop
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 * Service provider offer associated city entity.
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co)
 */
@Entity
@Table(name = "vhs_city")
@XmlRootElement
@NamedQueries
        (
            {
                @NamedQuery(name = "VhsCity.findAll", query = "SELECT v FROM VhsCity v"),
                @NamedQuery(name = "VhsCity.findByIdCity", query = "SELECT v FROM VhsCity v WHERE v.idCity = :idCity"),
                @NamedQuery(name = "VhsCity.findByDescription", query = "SELECT v FROM VhsCity v WHERE v.description = :description")
            }
        )
public class VhsCity implements Serializable
{
    /**
     * Default serial version UID
     */
    private static final long serialVersionUID = 1L;
<<<<<<< HEAD
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_city", nullable = false)
    private Integer idCity;
    @Size(max = 2147483647)
    @Column(name = "description", length = 2147483647)
=======
    
    /**
     * City identifier
     */
    @Id
    @Column(name = "id_city")
    private String idCity;
    
    /**
     * City name
     */
    @Column(name = "description")
>>>>>>> origin/develop
    private String description;
    
    /**
     * City owner country
     */
    @JoinColumn(name = "country_city", referencedColumnName = "id_country")
    @ManyToOne
    private VhsCountry countryCity;
    @OneToMany(mappedBy = "offerCity")
    private Collection<VhsSpecialOffer> vhsSpecialOfferCollection;

    public VhsCity()
    {
    }

    public VhsCity(String idCity)
    {
        this.idCity = idCity;
    }

    public String getIdCity()
    {
        return idCity;
    }

    public void setIdCity(String idCity)
    {
        this.idCity = idCity;
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    public VhsCountry getCountryCity()
    {
        return countryCity;
    }

    public void setCountryCity(VhsCountry countryCity)
    {
        this.countryCity = countryCity;
    }

    @XmlTransient
    public Collection<VhsSpecialOffer> getVhsSpecialOfferCollection() {
        return vhsSpecialOfferCollection;
    }

    public void setVhsSpecialOfferCollection(Collection<VhsSpecialOffer> vhsSpecialOfferCollection) {
        this.vhsSpecialOfferCollection = vhsSpecialOfferCollection;
    }

    @Override
    public int hashCode()
    {
        int hash = 0;
        hash += (idCity != null ? idCity.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object)
    {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof VhsCity))
        {
            return false;
        }
        VhsCity other = (VhsCity) object;
        if ((this.idCity == null && other.idCity != null) || (this.idCity != null && !this.idCity.equals(other.idCity)))
        {
            return false;
        }
        return true;
    }

    @Override
    public String toString()
    {
        return "com.vhs.data.VhsCity[ idCity=" + idCity + " ]";
    }

}
