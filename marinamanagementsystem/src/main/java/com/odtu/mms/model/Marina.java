package com.odtu.mms.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Type;
import org.hibernate.envers.Audited;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Audited
@Table(name="marina")
public class Marina extends BaseModel implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3081721582663893635L;

	@Column(name = "name", columnDefinition="text")
	@Type(type = "org.hibernate.type.TextType")
	private String name="";
	
	@Column(name = "status",columnDefinition="integer")
	@Type(type = "org.hibernate.type.NumericBooleanType")
	private Boolean status;

//	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="location_id")
	private Location location;

	@Column(name = "website", columnDefinition="text")
	@Type(type = "org.hibernate.type.TextType")
	private String website="";

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	public Location getLocation() {
		return location;
	}

	public void setLocation(Location location) {
		this.location = location;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

}
