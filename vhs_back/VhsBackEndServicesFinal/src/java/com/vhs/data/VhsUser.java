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
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author andresvargas
 */
@Entity
@Table(name = "vhs_user")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "VhsUser.findAll", query = "SELECT v FROM VhsUser v"),
    @NamedQuery(name = "VhsUser.findByUserId", query = "SELECT v FROM VhsUser v WHERE v.userId = :userId"),
    @NamedQuery(name = "VhsUser.findByMail", query = "SELECT v FROM VhsUser v WHERE v.mail = :mail"),
    @NamedQuery(name = "VhsUser.findByLogin", query = "SELECT v FROM VhsUser v WHERE v.mail = :mail and v.password = :password"),
    @NamedQuery(name = "VhsUser.findByPassword", query = "SELECT v FROM VhsUser v WHERE v.password = :password"),
    @NamedQuery(name = "VhsUser.findByFullName", query = "SELECT v FROM VhsUser v WHERE v.fullName = :fullName")})
public class VhsUser implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = true)
    @Column(name = "user_id", nullable = true)
    private Integer userId;
    @Size(max = 2147483647)
    @Column(name = "mail", length = 2147483647)
    private String mail;
    @Size(max = 2147483647)
    @Column(name = "password", length = 2147483647)
    private String password;
    @Size(max = 2147483647)
    @Column(name = "full_name", length = 2147483647)
    private String fullName;
    @Size(max = 2147483647)
    @Column(name = "user_kind")
    private String userKind;

    public VhsUser() {
    }

    public VhsUser(Integer userId) {
        this.userId = userId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getUserKind() {
        return userKind;
    }

    public void setUserKind(String userKind) {
        this.userKind = userKind;
    }


    @Override
    public int hashCode() {
        int hash = 0;
        hash += (userId != null ? userId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof VhsUser)) {
            return false;
        }
        VhsUser other = (VhsUser) object;
        if ((this.userId == null && other.userId != null) || (this.userId != null && !this.userId.equals(other.userId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.vhs.data.VhsUser[ userId=" + userId + " ]";
    }
    
}
