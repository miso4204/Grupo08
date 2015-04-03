/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.data;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
<<<<<<< HEAD
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
=======
>>>>>>> origin/develop
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 * Country entity.
 * 
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co)
 */
@Entity
@Table(name = "vhs_country")
@XmlRootElement
@NamedQueries
        (
            {
                @NamedQuery(name = "VhsCountry.findAll", query = "SELECT v FROM VhsCountry v"),
                @NamedQuery(name = "VhsCountry.findByIdCountry", query = "SELECT v FROM VhsCountry v WHERE v.idCountry = :idCountry"),
                @NamedQuery(name = "VhsCountry.findByDescription", query = "SELECT v FROM VhsCountry v WHERE v.description = :description")
            }
        )
public class VhsCountry implements Serializable
{
    /**
     * Default serial version UID
     */
    private static final long serialVersionUID = 1L;
    
    /**
     * Country identifier
     */
    @Id
<<<<<<< HEAD
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "id_country", nullable = false, length = 2147483647)
    private String idCountry;
    @Size(max = 2147483647)
    @Column(name = "description", length = 2147483647)
=======
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_country")
    private Integer idCountry;
    
    /**
     * Country name
     */
    @Column(name = "description")
>>>>>>> origin/develop
    private String description;
    
    /**
     * Country associated cities
     */
    @OneToMany(mappedBy = "countryCity")
    private Collection<VhsCity> vhsCityCollection;
    @OneToMany(mappedBy = "offerCountry")
    private Collection<VhsSpecialOffer> vhsSpecialOfferCollection;

    public VhsCountry()
    {
    }

<<<<<<< HEAD
    public VhsCountry(String idCountry) {
        this.idCountry = idCountry;
    }

    public String getIdCountry() {
        return idCountry;
    }

    public void setIdCountry(String idCountry) {
=======
    public VhsCountry(Integer idCountry)
    {
        this.idCountry = idCountry;
    }

    public Integer getIdCountry()
    {
        return idCountry;
    }

    public void setIdCountry(Integer idCountry)
    {
>>>>>>> origin/develop
        this.idCountry = idCountry;
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    @XmlTransient
    public Collection<VhsCity> getVhsCityCollection()
    {
        return vhsCityCollection;
    }

    public void setVhsCityCollection(Collection<VhsCity> vhsCityCollection)
    {
        this.vhsCityCollection = vhsCityCollection;
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
        hash += (idCountry != null ? idCountry.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object)
    {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof VhsCountry))
        {
            return false;
        }
        VhsCountry other = (VhsCountry) object;
        if ((this.idCountry == null && other.idCountry != null) || (this.idCountry != null && !this.idCountry.equals(other.idCountry)))
        {
            return false;
        }
        return true;
    }

    @Override
    public String toString()
    {
        return "com.vhs.data.VhsCountry[ idCountry=" + idCountry + " ]";
    }

}
