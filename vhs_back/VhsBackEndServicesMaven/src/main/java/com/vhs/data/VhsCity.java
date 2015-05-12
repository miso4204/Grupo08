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
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

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
                @NamedQuery(name = "VhsCity.findByDescription", query = "SELECT v FROM VhsCity v WHERE v.description = :description"),
                @NamedQuery(name = "VhsCity.findByMain", query = "SELECT v FROM VhsCity v WHERE v.main = true")
            }
        )
public class VhsCity implements Serializable
{
    /**
     * Default serial version UID
     */
    private static final long serialVersionUID = 1L;
    
    /**
     * City identifier
     */
    @Id
    @Column(name = "id_city")
    private Long idCity;
    
    /**
     * City name
     */
    @Column(name = "description")
    private String description;
    
    /**
     * Latitude
     */
    @Column(name = "lat")
    private String lat;
    
    /**
     * Longitude
     */
    @Column(name = "lon")
    private String lon;
    
    @Column(name = "main")
    private Boolean main;
    
    /**
     * City owner country
     */
    @JoinColumn(name = "country_city", referencedColumnName = "id_country")
    @ManyToOne (fetch = FetchType.EAGER)
    private VhsCountry countryCity;
    
    
    @OneToMany(mappedBy = "offerCity")
    @LazyCollection(LazyCollectionOption.FALSE)
    private Collection<VhsSpecialOffer> vhsSpecialOffer;

    public VhsCity()
    {
    }

    public VhsCity(Long idCity)
    {
        this.idCity = idCity;
    }

    public long getIdCity()
    {
        return idCity;
    }

    public void setIdCity(Long idCity)
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

    public Collection<VhsSpecialOffer> getVhsSpecialOffer() {
        return vhsSpecialOffer;
    }

    public void setVhsSpecialOffer(Collection<VhsSpecialOffer> vhsSpecialOffer) {
        this.vhsSpecialOffer = vhsSpecialOffer;
    }

    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat;
    }

    public String getLon() {
        return lon;
    }

    public void setLon(String lon) {
        this.lon = lon;
    }

    public Boolean getMain() {
        return main;
    }

    public void setMain(Boolean main) {
        this.main = main;
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
