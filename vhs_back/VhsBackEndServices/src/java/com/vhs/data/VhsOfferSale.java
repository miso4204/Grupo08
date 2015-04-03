/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vhs.data;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Offer sale entity
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co)
 */
@Entity
public class VhsOfferSale implements Serializable
{
    /**
     * Default serial version UID
     */
    private static final long serialVersionUID = 1L;
    
    /**
     * Sale identifier
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    /**
     * Buyer email
     */
    @Column(name = "email")
    private String buyerEmail;
    
    /**
     * Buyer address
     */
    @Column(name = "address")
    private String buyerAddress;
    
    /**
     * Buyer name
     */
    @Column(name = "name")
    private String buyerName;
    
    /**
     * Buyer city
     */
    @JoinColumn(name = "city", referencedColumnName = "id_city")
    @ManyToOne
    private VhsCity buyerCity;
    
    /**
     * Credit card number
     */
    @Column(name = "credit_card_number")
    private String creditCardNumber;
    
    /**
     * Credit card franchise
     */
    @Column(name = "credit_card_franchise")
    private String creditCardFranchise;
    
    /**
     * Credit card verification code
     */
    @Column(name = "credit_card_verification_code")
    private String creditCardVerificationCode;
    
    /**
     * Credit card expiration month
     */
    @Column(name = "credit_card_expiration_month")
    private String creditCardExpirationMonth;
    
    /**
     * Credit card expiration year
     */
    @Column(name = "credit_card_expiration_year")
    private String creditCardExpirationYear;
    
    /**
     * PSE associated bank
     */
    @Column(name = "pse_bank_name")
    private String pseBankName;
    
    /**
     * PSE associated account number
     */
    @Column(name = "pse_account_number")
    private String pseAccountNumber;
    
    /**
     * Number of products bought
     */
    @Column(name = "sale_quantity")
    private String saleQuantity;
    
    /**
     * Total sale
     */
    @Column(name = "total_sale")
    private Double totalSale;
    
    /**
     * Current date
     */
    @Column(name = "sale_date")
    @Temporal(TemporalType.DATE)
    private Date saleDate;
    /**
     * Associated payment method
     */
    @JoinColumn(name = "payment_method", referencedColumnName = "id_payment")
    @ManyToOne
    private VhsPaymentMethod paymentMethod;
    
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

    public VhsSpecialOffer getSpecialOffer()
    {
        return specialOffer;
    }

    public void setSpecialOffer(VhsSpecialOffer specialOffer)
    {
        this.specialOffer = specialOffer;
    }

    public String getBuyerEmail()
    {
        return buyerEmail;
    }

    public void setBuyerEmail(String buyerEmail)
    {
        this.buyerEmail = buyerEmail;
    }

    public String getBuyerAddress()
    {
        return buyerAddress;
    }

    public void setBuyerAddress(String buyerAddress)
    {
        this.buyerAddress = buyerAddress;
    }

    public String getBuyerName()
    {
        return buyerName;
    }

    public void setBuyerName(String buyerName)
    {
        this.buyerName = buyerName;
    }

    public VhsCity getBuyerCity()
    {
        return buyerCity;
    }

    public void setBuyerCity(VhsCity buyerCity)
    {
        this.buyerCity = buyerCity;
    }

    public String getCreditCardNumber()
    {
        return creditCardNumber;
    }

    public void setCreditCardNumber(String creditCardNumber)
    {
        this.creditCardNumber = creditCardNumber;
    }

    public String getCreditCardFranchise()
    {
        return creditCardFranchise;
    }

    public void setCreditCardFranchise(String creditCardFranchise)
    {
        this.creditCardFranchise = creditCardFranchise;
    }

    public String getCreditCardVerificationCode()
    {
        return creditCardVerificationCode;
    }

    public void setCreditCardVerificationCode(String creditCardVerificationCode)
    {
        this.creditCardVerificationCode = creditCardVerificationCode;
    }

    public String getCreditCardExpirationMonth()
    {
        return creditCardExpirationMonth;
    }

    public void setCreditCardExpirationMonth(String creditCardExpirationMonth)
    {
        this.creditCardExpirationMonth = creditCardExpirationMonth;
    }

    public String getCreditCardExpirationYear()
    {
        return creditCardExpirationYear;
    }

    public void setCreditCardExpirationYear(String creditCardExpirationYear)
    {
        this.creditCardExpirationYear = creditCardExpirationYear;
    }

    public String getPseBankName()
    {
        return pseBankName;
    }

    public void setPseBankName(String pseBankName)
    {
        this.pseBankName = pseBankName;
    }

    public String getPseAccountNumber()
    {
        return pseAccountNumber;
    }

    public void setPseAccountNumber(String pseAccountNumber)
    {
        this.pseAccountNumber = pseAccountNumber;
    }

    public String getSaleQuantity()
    {
        return saleQuantity;
    }

    public void setSaleQuantity(String saleQuantity)
    {
        this.saleQuantity = saleQuantity;
    }

    public Double getTotalSale()
    {
        return totalSale;
    }

    public void setTotalSale(Double totalSale)
    {
        this.totalSale = totalSale;
    }

    public VhsPaymentMethod getPaymentMethod()
    {
        return paymentMethod;
    }

    public void setPaymentMethod(VhsPaymentMethod paymentMethod)
    {
        this.paymentMethod = paymentMethod;
    }

    public Date getSaleDate()
    {
        return saleDate;
    }

    public void setSaleDate(Date saleDate)
    {
        this.saleDate = saleDate;
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
        if (!(object instanceof VhsOfferSale))
        {
            return false;
        }
        VhsOfferSale other = (VhsOfferSale) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id)))
        {
            return false;
        }
        return true;
    }

    @Override
    public String toString()
    {
        return "com.vhs.data.VhsOfferSale[ id=" + id + " ]";
    }
    
}
