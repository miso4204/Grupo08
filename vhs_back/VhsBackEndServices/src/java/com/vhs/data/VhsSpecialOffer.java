package com.vhs.data;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Service provider offer entity. Stores the turistic product description
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co)
 */
@Entity
@Table(name = "vhs_special_offer")
@XmlRootElement
@NamedQueries
        (
            {
                @NamedQuery(name = "VhsSpecialOffer.findAll", query = "SELECT v FROM VhsSpecialOffer v"),
                @NamedQuery(name = "VhsSpecialOffer.findByIdSpecialOffers", query = "SELECT v FROM VhsSpecialOffer v WHERE v.idSpecialOffers = :idSpecialOffers"),
                @NamedQuery(name = "VhsSpecialOffer.findByShortName", query = "SELECT v FROM VhsSpecialOffer v WHERE v.shortName = :shortName"),
                @NamedQuery(name = "VhsSpecialOffer.findByDescription", query = "SELECT v FROM VhsSpecialOffer v WHERE v.description = :description"),
                @NamedQuery(name = "VhsSpecialOffer.findByPrice", query = "SELECT v FROM VhsSpecialOffer v WHERE v.price = :price"),
                @NamedQuery(name = "VhsSpecialOffer.findByMainImageUrl", query = "SELECT v FROM VhsSpecialOffer v WHERE v.mainImageUrl = :mainImageUrl"),
                @NamedQuery(name = "VhsSpecialOffer.findByLatitude", query = "SELECT v FROM VhsSpecialOffer v WHERE v.latitude = :latitude"),
                @NamedQuery(name = "VhsSpecialOffer.findByLongitude", query = "SELECT v FROM VhsSpecialOffer v WHERE v.longitude = :longitude"),
                @NamedQuery(name = "VhsSpecialOffer.findByPublishDate", query = "SELECT v FROM VhsSpecialOffer v WHERE v.publishDate = :publishDate"),
                @NamedQuery(name = "VhsSpecialOffer.findByEndDate", query = "SELECT v FROM VhsSpecialOffer v WHERE v.endDate = :endDate")
            }
        )
public class VhsSpecialOffer implements Serializable
{

    /**
     * Default serial version UID
     */
    private static final long serialVersionUID = 1L;

    /**
     * Special offer identifier
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_special_offers")
    private Integer idSpecialOffers;

    /**
     * Offer short name
     */
    @Column(name = "short_name")
    private String shortName;

    /**
     * Offer long description
     */
    @Column(name = "description")
    private String description;

    /**
     * Offer price
     */
    @Column(name = "price", precision = 17, scale = 17)
    private Double price;
    
    /**
     * Offer thumbnail image absolute URL
     */
    @Column(name = "main_image_url")
    private String mainImageUrl;
    
    /**
     * Turistic product latitude
     */
    @Column(name = "latitude", precision = 17, scale = 17)
    private Double latitude;
    
    /**
     * Turistic product longitude
     */
    @Column(name = "longitude", precision = 17, scale = 17)
    private Double longitude;
    
    /**
     * Current date
     */
    @Column(name = "publish_date")
    @Temporal(TemporalType.DATE)
    private Date publishDate;
    
    /**
     * Product publication end date
     */
    @Column(name = "end_date")
    @Temporal(TemporalType.DATE)
    private Date endDate;
    
    /**
     * Service promotion flag. True the current service is promotion. False otherwise
     */
    @Column(name = "service_promo")
    private Boolean servicePromo;
    
    /**
     * Product category
     */
    @JoinColumn(name = "offer_category", referencedColumnName = "id_category")
    @ManyToOne
    private VhsCategory offerCategory;
    
    /**
     * Product owner
     */
    @JoinColumn(name = "service_provider", referencedColumnName = "user_id")
    @ManyToOne
    private VhsUser serviceProviderUser;

    /**
     * Product city
     */
    @JoinColumn(name = "city", referencedColumnName = "id_city")
    @ManyToOne
    private VhsCity offerCity;
    
    /**
     * Associated offers
     */
    @OneToMany(mappedBy = "specialOffer")
    private Collection<VhsOfferRating> vhsOfferRating;
    
    /**
     * Associated sales
     */
    @OneToMany(mappedBy = "specialOffer")
    private Collection<VhsOfferSale> vhsOfferSale;
    
    /**
     * Current offer price currency
     */
    @JoinColumn(name = "currency", referencedColumnName = "id")
    @ManyToOne
    private VhsSupportedCurrency currency;
    
    public VhsSpecialOffer()
    {
    }

    public VhsSpecialOffer(Integer idSpecialOffers)
    {
        this.idSpecialOffers = idSpecialOffers;
    }

    public Integer getIdSpecialOffers()
    {
        return idSpecialOffers;
    }

    public void setIdSpecialOffers(Integer idSpecialOffers)
    {
        this.idSpecialOffers = idSpecialOffers;
    }

    public String getShortName()
    {
        return shortName;
    }

    public void setShortName(String shortName)
    {
        this.shortName = shortName;
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    public Double getPrice()
    {
        return price;
    }

    public void setPrice(Double price)
    {
        this.price = price;
    }

    public String getMainImageUrl()
    {
        return mainImageUrl;
    }

    public void setMainImageUrl(String mainImageUrl)
    {
        this.mainImageUrl = mainImageUrl;
    }

    public Double getLatitude()
    {
        return latitude;
    }

    public void setLatitude(Double latitude)
    {
        this.latitude = latitude;
    }

    public Double getLongitude()
    {
        return longitude;
    }

    public void setLongitude(Double longitude)
    {
        this.longitude = longitude;
    }

    public Date getPublishDate()
    {
        return publishDate;
    }

    public void setPublishDate(Date publishDate)
    {
        this.publishDate = publishDate;
    }

    public Date getEndDate()
    {
        return endDate;
    }

    public void setEndDate(Date endDate)
    {
        this.endDate = endDate;
    }

    public VhsCategory getOfferCategory()
    {
        return offerCategory;
    }

    public void setOfferCategory(VhsCategory offerCategory)
    {
        this.offerCategory = offerCategory;
    }

    public Boolean getServicePromo()
    {
        return servicePromo;
    }

    public void setServicePromo(Boolean servicePromo)
    {
        this.servicePromo = servicePromo;
    }

    public VhsUser getServiceProviderUser()
    {
        return serviceProviderUser;
    }

    public void setServiceProviderUser(VhsUser serviceProviderUser)
    {
        this.serviceProviderUser = serviceProviderUser;
    }

    public VhsCity getOfferCity()
    {
        return offerCity;
    }

    public void setOfferCity(VhsCity offerCity)
    {
        this.offerCity = offerCity;
    }

    public Collection<VhsOfferRating> getVhsOfferRating()
    {
        return vhsOfferRating;
    }

    public void setVhsOfferRating(Collection<VhsOfferRating> vhsOfferRating)
    {
        this.vhsOfferRating = vhsOfferRating;
    }

    public Collection<VhsOfferSale> getVhsOfferSale()
    {
        return vhsOfferSale;
    }

    public void setVhsOfferSale(Collection<VhsOfferSale> vhsOfferSale)
    {
        this.vhsOfferSale = vhsOfferSale;
    }

    public VhsSupportedCurrency getCurrency()
    {
        return currency;
    }

    public void setCurrency(VhsSupportedCurrency currency)
    {
        this.currency = currency;
    }

    @Override
    public int hashCode()
    {
        int hash = 0;
        hash += (idSpecialOffers != null ? idSpecialOffers.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object)
    {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof VhsSpecialOffer))
        {
            return false;
        }
        VhsSpecialOffer other = (VhsSpecialOffer) object;
        if ((this.idSpecialOffers == null && other.idSpecialOffers != null) || (this.idSpecialOffers != null && !this.idSpecialOffers.equals(other.idSpecialOffers)))
        {
            return false;
        }
        return true;
    }

    @Override
    public String toString()
    {
        return "com.vhs.data.VhsSpecialOffer[ idSpecialOffers=" + idSpecialOffers + " ]";
    }

}
