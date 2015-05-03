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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author ivanfgarcias
 */
@Entity
@XmlRootElement
@Table(name = "vhssocialnetwork")
@NamedQueries(
        {
            @NamedQuery(name="VhsSocialNetwork.findAll",query=" select v from VhsSocialNetwork v"),
            @NamedQuery(name="VhsSocialNetwork.findAllBasic",query=" select v from VhsSocialNetwork v WHERE v.optional = false"),
        }
)
public class VhsSocialNetwork implements Serializable
{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_social_network")
    private Long id;
    
    @Column(name = "name")
    private String name;

      @Column(name = "optional")
    private Boolean optional;

    public Boolean getOptional() {
        return optional;
    }

    public void setOptional(Boolean optional) {
        this.optional = optional;
    }
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "VhsSocialNetwork{" + "id=" + id + ", name=" + name + ", optional=" + optional + '}';
    }
    
    @Override
    public boolean equals(Object object)
    {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof VhsSocialNetwork))
        {
            return false;
        }
        VhsSocialNetwork other = (VhsSocialNetwork) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id)))
        {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }
}
