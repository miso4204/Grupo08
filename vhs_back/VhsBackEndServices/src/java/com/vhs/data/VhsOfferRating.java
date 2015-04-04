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
 * Service provider offer rating
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co)
 */
@Entity
@XmlRootElement
public class VhsOfferRating implements Serializable
{
    /**
     * Default serial version UID
     */
    private static final long serialVersionUID = 1L;
    
     /**
     * Rating identifier
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    /**
     * Email associated to the user that is qualifying the service
     */
    @Column(name = "email")
    private String ratingEmail;
    
    /**
     * Name associated to the user that is qualifying the service
     */
    @Column(name = "name")
    private String ratingName;
    
    /**
     * Comments associated to the user that is qualifying the service
     */
    @Column(name = "comments")
    private String ratingComments;
    
    /**
     * Current score associated to the user that is qualifying the service: 1-5
     */
    @Column(name = "score")
    private Integer score;
    
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

    public String getRatingEmail()
    {
        return ratingEmail;
    }

    public void setRatingEmail(String ratingEmail)
    {
        this.ratingEmail = ratingEmail;
    }

    public String getRatingName()
    {
        return ratingName;
    }

    public void setRatingName(String ratingName)
    {
        this.ratingName = ratingName;
    }

    public String getRatingComments()
    {
        return ratingComments;
    }

    public void setRatingComments(String ratingComments)
    {
        this.ratingComments = ratingComments;
    }

    public Integer getScore()
    {
        return score;
    }

    public void setScore(Integer score)
    {
        this.score = score;
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
        if (!(object instanceof VhsOfferRating))
        {
            return false;
        }
        VhsOfferRating other = (VhsOfferRating) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id)))
        {
            return false;
        }
        return true;
    }

    @Override
    public String toString()
    {
        return "com.vhs.data.VhsOfferRating[ id=" + id + " ]";
    }
    
}
