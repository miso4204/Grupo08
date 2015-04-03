/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.data;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
 
/**
 * Service provider entity. Stores personal information and optional features used in the VHS platform
 * 
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co)
 */
@Entity
@Table(name = "vhs_user")
@XmlRootElement
@NamedQueries
        (
                {
                    @NamedQuery(name = "VhsUser.findAll", query = "SELECT v FROM VhsUser v"),
                    @NamedQuery(name = "VhsUser.findByUserId", query = "SELECT v FROM VhsUser v WHERE v.userId = :userId"),
                    @NamedQuery(name = "VhsUser.findByMail", query = "SELECT v FROM VhsUser v WHERE v.mail = :mail"),
                    @NamedQuery(name = "VhsUser.findByLogin", query = "SELECT v FROM VhsUser v WHERE v.mail = :mail and v.password = :password"),
                    @NamedQuery(name = "VhsUser.findByPassword", query = "SELECT v FROM VhsUser v WHERE v.password = :password"),
                    @NamedQuery(name = "VhsUser.findByFullName", query = "SELECT v FROM VhsUser v WHERE v.fullName = :fullName")
                }
        )
public class VhsUser implements Serializable 
{
    @Size(max = 2147483647)
    @Column(name = "user_kind", length = 2147483647)
    private String userKind;
    
    /**
     * Default serial version UID
     */
    private static final long serialVersionUID = 1L;
    
    /**
     * User identifier
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = true)
    @Column(name = "user_id", nullable = true)
    private Integer userId;
    
    /**
     * Servide provider mail
     */
    @Size(max = 2147483647)
    @Column(name = "mail", length = 2147483647)
    private String mail;
    
    /**
     * Service provider password
     */
    @Size(max = 2147483647)
    @Column(name = "password", length = 2147483647)
    private String password;
    
    /**
     * Servide provider full name
     */
    @Size(max = 2147483647)
    @Column(name = "full_name", length = 2147483647)
    private String fullName;
    
    /**
     * Optional feature used to determinate if the service provider could manage special offer in their turistic products
     */
    @Column(name = "optional_feature_special_offer")
    private Boolean optionalFeatureSpecialOffer;
    
    /**
     * Optional feature used to determinate if the service provider could manage other currencies
     */
    @Column(name = "optional_feature_currency_management")
    private Boolean optionalFeatureCurrencyManagement;
    
    /**
     * Optional feature used to determinate if the productos associated to the service provider could be found in a search by location
     */
    @Column(name = "optional_feature_search_by_location")
    private Boolean optionalFeatureSearchByLocation;
    
    /**
     * Optional feature used to determinate if the productos associated to the service provider could be payed with cash on delivery
     */
    @Column(name = "optional_feature_cash_pay_on_delivery")
    private Boolean optionalFeatureCashPayOnDelivery;
    
    /**
     * Optional feature used to determinate if the productos associated to the service provider could be published in the facebook wall or could be twitted
     */
    @Column(name = "optional_feature_social_networks")
    private Boolean optionalFeatureSocialNetworks; 
    
    /**
     * Optional feature used to determinate if the service provider could geerated reports by rating
     */
    @Column(name = "optional_feature_reports_by_rating")
    private Boolean optionalFeatureReportsByRating; 
    
    /**
     * Optional feature used to determinate if the service provider could geerated reports by sales
     */
    @Column(name = "optional_feature_reports_by_sales")
    private Boolean optionalFeatureReportsBySales; 
    
    /**
     * Optional feature used to determinate if the service provider could use hardware scalability 
     */
    @Column(name = "optional_feature_scalability")
    private Boolean optionalFeatureScalability;
    
    /**
     * Optional feature used to determinate if the service provider could use network balancing
     */
    @Column(name = "optional_feature_performance")
    private Boolean optionalFeaturePerformance;
    
    public VhsUser() 
    {
        
    }

    public VhsUser(Integer userId) 
    {
        this.userId = userId;
    }

    public Integer getUserId() 
    {
        return userId;
    }

    public void setUserId(Integer userId) 
    {
        this.userId = userId;
    }

    public String getMail() 
    {
        return mail;
    }

    public void setMail(String mail) 
    {
        this.mail = mail;
    }

    public String getPassword() 
    {
        return password;
    }

    public void setPassword(String password) 
    {
        this.password = password;
    }

    public String getFullName() 
    {
        return fullName;
    }

    public void setFullName(String fullName) 
    {
        this.fullName = fullName;
    }

    public Boolean getOptionalFeatureSpecialOffer() 
    {
        return optionalFeatureSpecialOffer;
    }

    public void setOptionalFeatureSpecialOffer(Boolean optionalFeatureSpecialOffer) 
    {
        this.optionalFeatureSpecialOffer = optionalFeatureSpecialOffer;
    }

    public Boolean getOptionalFeatureCurrencyManagement() 
    {
        return optionalFeatureCurrencyManagement;
    }

    public void setOptionalFeatureCurrencyManagement(Boolean optionalFeatureCurrencyManagement) 
    {
        this.optionalFeatureCurrencyManagement = optionalFeatureCurrencyManagement;
    }

    public Boolean getOptionalFeatureSearchByLocation() 
    {
        return optionalFeatureSearchByLocation;
    }

    public void setOptionalFeatureSearchByLocation(Boolean optionalFeatureSearchByLocation) 
    {
        this.optionalFeatureSearchByLocation = optionalFeatureSearchByLocation;
    }

    public Boolean getOptionalFeatureCashPayOnDelivery() 
    {
        return optionalFeatureCashPayOnDelivery;
    }

    public void setOptionalFeatureCashPayOnDelivery(Boolean optionalFeatureCashPayOnDelivery) 
    {
        this.optionalFeatureCashPayOnDelivery = optionalFeatureCashPayOnDelivery;
    }

    public Boolean getOptionalFeatureSocialNetworks() 
    {
        return optionalFeatureSocialNetworks;
    }

    public void setOptionalFeatureSocialNetworks(Boolean optionalFeatureSocialNetworks) 
    {
        this.optionalFeatureSocialNetworks = optionalFeatureSocialNetworks;
    }

    public Boolean getOptionalFeatureReportsByRating() 
    {
        return optionalFeatureReportsByRating;
    }

    public void setOptionalFeatureReportsByRating(Boolean optionalFeatureReportsByRating) 
    {
        this.optionalFeatureReportsByRating = optionalFeatureReportsByRating;
    }

    public Boolean getOptionalFeatureReportsBySales() 
    {
        return optionalFeatureReportsBySales;
    }

    public void setOptionalFeatureReportsBySales(Boolean optionalFeatureReportsBySales) 
    {
        this.optionalFeatureReportsBySales = optionalFeatureReportsBySales;
    }

    public Boolean getOptionalFeatureScalability() 
    {
        return optionalFeatureScalability;
    }

    public void setOptionalFeatureScalability(Boolean optionalFeatureScalability) 
    {
        this.optionalFeatureScalability = optionalFeatureScalability;
    }

    public Boolean getOptionalFeaturePerformance() 
    {
        return optionalFeaturePerformance;
    }

    public void setOptionalFeaturePerformance(Boolean optionalFeaturePerformance) 
    {
        this.optionalFeaturePerformance = optionalFeaturePerformance;
    }

    @Override
    public int hashCode() 
    {
        int hash = 0;
        hash += (userId != null ? userId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) 
    {
        if (!(object instanceof VhsUser)) 
        {
            return false;
        }
        VhsUser other = (VhsUser) object;
        if ((this.userId == null && other.userId != null) || (this.userId != null && !this.userId.equals(other.userId))) 
        {
            return false;
        }
        return true;
    }

    @Override
    public String toString() 
    {
        return "com.vhs.data.VhsUser[ userId=" + userId + " ]";
    }

    public String getUserKind() {
        return userKind;
    }

    public void setUserKind(String userKind) {
        this.userKind = userKind;
    }
    
}
