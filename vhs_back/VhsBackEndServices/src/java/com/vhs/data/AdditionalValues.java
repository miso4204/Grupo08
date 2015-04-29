package com.vhs.data;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Service provider offer entity. Stores the turistic product description
 *
 * @author Andres Vargas (ja.vargas147@uniandes.edu.co)
 * @author Alex Vicente ChacOn JimEnez (av.chacon10@uniandes.edu.co)
 */
@Entity 
@XmlRootElement
@Table(name = "additionalvalues")
public class AdditionalValues implements Serializable
{
    /**
     * Default serial version UID
     */
    private static final long serialVersionUID = 1L;

    /**
     * Currency identifier
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    
    /**
     * Attribute title
     */
    @Column(name = "title")
    private String title;
    
    /**
     * Attribute value
     */
    @Column(name = "currentValue")
    private String currentValue;

    /**
     * Associated special offer
     */
    @JoinColumn(name = "special_offer", referencedColumnName = "id_special_offers")
    @ManyToOne (fetch = FetchType.EAGER)
    private VhsSpecialOffer specialOffer;
    
    public String getTitle()
    {
        return title;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getCurrentValue()
    {
        return currentValue;
    }

    public void setCurrentValue(String currentValue)
    {
        this.currentValue = currentValue;
    }

    public VhsSpecialOffer getSpecialOffer()
    {
        return specialOffer;
    }

    public void setSpecialOffer(VhsSpecialOffer specialOffer)
    {
        this.specialOffer = specialOffer;
    }
    
    
}
