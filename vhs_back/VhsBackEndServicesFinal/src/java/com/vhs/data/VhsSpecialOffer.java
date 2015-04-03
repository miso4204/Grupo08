/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.data;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author andresvargas
 */
@Entity
@Table(name = "vhs_special_offer")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "VhsSpecialOffer.findAll", query = "SELECT v FROM VhsSpecialOffer v"),
    @NamedQuery(name = "VhsSpecialOffer.findByIdSpecialOffers", query = "SELECT v FROM VhsSpecialOffer v WHERE v.idSpecialOffers = :idSpecialOffers"),
    @NamedQuery(name = "VhsSpecialOffer.findByShortName", query = "SELECT v FROM VhsSpecialOffer v WHERE v.shortName = :shortName"),
    @NamedQuery(name = "VhsSpecialOffer.findByDescription", query = "SELECT v FROM VhsSpecialOffer v WHERE v.description = :description"),
    @NamedQuery(name = "VhsSpecialOffer.findByPrice", query = "SELECT v FROM VhsSpecialOffer v WHERE v.price = :price"),
    @NamedQuery(name = "VhsSpecialOffer.findByMainImageUrl", query = "SELECT v FROM VhsSpecialOffer v WHERE v.mainImageUrl = :mainImageUrl"),
    @NamedQuery(name = "VhsSpecialOffer.findByLatitude", query = "SELECT v FROM VhsSpecialOffer v WHERE v.latitude = :latitude"),
    @NamedQuery(name = "VhsSpecialOffer.findByLongitude", query = "SELECT v FROM VhsSpecialOffer v WHERE v.longitude = :longitude"),
    @NamedQuery(name = "VhsSpecialOffer.findByPublishDate", query = "SELECT v FROM VhsSpecialOffer v WHERE v.publishDate = :publishDate"),
    @NamedQuery(name = "VhsSpecialOffer.findByEndDate", query = "SELECT v FROM VhsSpecialOffer v WHERE v.endDate = :endDate")})
public class VhsSpecialOffer implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_special_offers", nullable = false)
    private Integer idSpecialOffers;
    @Size(max = 2147483647)
    @Column(name = "short_name", length = 2147483647)
    private String shortName;
    @Size(max = 2147483647)
    @Column(name = "description", length = 2147483647)
    private String description;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "price", precision = 17, scale = 17)
    private Double price;
    @Size(max = 2147483647)
    @Column(name = "main_image_url", length = 2147483647)
    private String mainImageUrl;
    @Column(name = "latitude", precision = 17, scale = 17)
    private Double latitude;
    @Column(name = "longitude", precision = 17, scale = 17)
    private Double longitude;
    @Column(name = "publish_date")
    @Temporal(TemporalType.DATE)
    private Date publishDate;
    @Column(name = "end_date")
    @Temporal(TemporalType.DATE)
    private Date endDate;
    @JoinColumn(name = "offer_country", referencedColumnName = "id_country")
    @ManyToOne
    private VhsCountry offerCountry;
    @JoinColumn(name = "offer_city", referencedColumnName = "id_city")
    @ManyToOne
    private VhsCity offerCity;
    @JoinColumn(name = "offer_category", referencedColumnName = "id_category")
    @ManyToOne
    private VhsCategory offerCategory;

    public VhsSpecialOffer() {
    }

    public VhsSpecialOffer(Integer idSpecialOffers) {
        this.idSpecialOffers = idSpecialOffers;
    }

    public Integer getIdSpecialOffers() {
        return idSpecialOffers;
    }

    public void setIdSpecialOffers(Integer idSpecialOffers) {
        this.idSpecialOffers = idSpecialOffers;
    }

    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getMainImageUrl() {
        return mainImageUrl;
    }

    public void setMainImageUrl(String mainImageUrl) {
        this.mainImageUrl = mainImageUrl;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public VhsCountry getOfferCountry() {
        return offerCountry;
    }

    public void setOfferCountry(VhsCountry offerCountry) {
        this.offerCountry = offerCountry;
    }

    public VhsCity getOfferCity() {
        return offerCity;
    }

    public void setOfferCity(VhsCity offerCity) {
        this.offerCity = offerCity;
    }

    public VhsCategory getOfferCategory() {
        return offerCategory;
    }

    public void setOfferCategory(VhsCategory offerCategory) {
        this.offerCategory = offerCategory;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idSpecialOffers != null ? idSpecialOffers.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof VhsSpecialOffer)) {
            return false;
        }
        VhsSpecialOffer other = (VhsSpecialOffer) object;
        if ((this.idSpecialOffers == null && other.idSpecialOffers != null) || (this.idSpecialOffers != null && !this.idSpecialOffers.equals(other.idSpecialOffers))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.vhs.data.VhsSpecialOffer[ idSpecialOffers=" + idSpecialOffers + " ]";
    }
    
}
