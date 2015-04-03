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
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 * Service provider offer associated category entity.
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co)
 */
@Entity
@Table(name = "vhs_category")
@XmlRootElement
@NamedQueries
        (
            {
                @NamedQuery(name = "VhsCategory.findAll", query = "SELECT v FROM VhsCategory v"),
                @NamedQuery(name = "VhsCategory.findByIdCategory", query = "SELECT v FROM VhsCategory v WHERE v.idCategory = :idCategory"),
                @NamedQuery(name = "VhsCategory.findByDescription", query = "SELECT v FROM VhsCategory v WHERE v.description = :description")
            }
        )
public class VhsCategory implements Serializable
{

    /**
     * Default serial version UID
     */
    private static final long serialVersionUID = 1L;
    
     /**
     * Category identifier
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_category")
    private Integer idCategory;
    
    /**
     * Category name and description
     */
    @Column(name = "description")
    private String description;
    
    /**
     * Associated offers
     */
    @OneToMany(mappedBy = "offerCategory")
    private Collection<VhsSpecialOffer> vhsSpecialOfferCollection;

    public VhsCategory()
    {
    }

    public VhsCategory(Integer idCategory)
    {
        this.idCategory = idCategory;
    }

    public Integer getIdCategory()
    {
        return idCategory;
    }

    public void setIdCategory(Integer idCategory)
    {
        this.idCategory = idCategory;
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
    public Collection<VhsSpecialOffer> getVhsSpecialOfferCollection()
    {
        return vhsSpecialOfferCollection;
    }

    public void setVhsSpecialOfferCollection(Collection<VhsSpecialOffer> vhsSpecialOfferCollection)
    {
        this.vhsSpecialOfferCollection = vhsSpecialOfferCollection;
    }

    @Override
    public int hashCode()
    {
        int hash = 0;
        hash += (idCategory != null ? idCategory.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object)
    {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof VhsCategory))
        {
            return false;
        }
        VhsCategory other = (VhsCategory) object;
        if ((this.idCategory == null && other.idCategory != null) || (this.idCategory != null && !this.idCategory.equals(other.idCategory)))
        {
            return false;
        }
        return true;
    }

    @Override
    public String toString()
    {
        return "com.vhs.data.VhsCategory[ idCategory=" + idCategory + " ]";
    }

}
