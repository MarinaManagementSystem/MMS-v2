package com.odtu.mms.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Type;
import org.hibernate.envers.Audited;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Audited
@Table(name="berth")
public class Berth extends BaseModel implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6856029243937739896L;

//	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="berth_type_id")
	private BerthType berthType;

//	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="marina_id")
	private Marina marina;
	
	@Column(name = "name", columnDefinition="text")
	@Type(type = "org.hibernate.type.TextType")
	private String name="";
	
	@Column(name = "status",columnDefinition="integer")
	@Type(type = "org.hibernate.type.NumericBooleanType")
	private Boolean status;
	
	@Column(name = "electricity_capacity")
	private Double electricityCapacity;
	
	@Column(name = "water_capacity")
	private Double waterCapacity;
	
	@Column(name = "fuel_capacity")
	private Double fuelCapacity;
	
	@Column(name = "min_length")
	private Double minLength;
	
	@Column(name = "max_length")
	private Double maxLength;
	
	@Column(name = "min_width")
	private Double minWidth;
	
	@Column(name = "max_width")
	private Double maxWidth;

//	@ManyToMany(targetEntity = Service.class, fetch = FetchType.EAGER,cascade=CascadeType.ALL)
//	@JoinTable(name = "berth_service", joinColumns = @JoinColumn(name = "berth_id"), inverseJoinColumns = @JoinColumn(name = "service_id"))
//	private List<Service> roller = new ArrayList<Service>();

	@Column(name = "latitude", columnDefinition="text")
	@Type(type = "org.hibernate.type.TextType")
	private String latitude="";

	@Column(name = "longitude", columnDefinition="text")
	@Type(type = "org.hibernate.type.TextType")
	private String longitude="";

	public BerthType getBerthType() {
		return berthType;
	}

	public void setBerthType(BerthType berthType) {
		this.berthType = berthType;
	}

	public Marina getMarina() {
		return marina;
	}

	public void setMarina(Marina marina) {
		this.marina = marina;
	}

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

	public Double getElectricityCapacity() {
		return electricityCapacity;
	}

	public void setElectricityCapacity(Double electricityCapacity) {
		this.electricityCapacity = electricityCapacity;
	}

	public Double getWaterCapacity() {
		return waterCapacity;
	}

	public void setWaterCapacity(Double waterCapacity) {
		this.waterCapacity = waterCapacity;
	}

	public Double getFuelCapacity() {
		return fuelCapacity;
	}

	public void setFuelCapacity(Double fuelCapacity) {
		this.fuelCapacity = fuelCapacity;
	}

	public Double getMinLength() {
		return minLength;
	}

	public void setMinLength(Double minLength) {
		this.minLength = minLength;
	}

	public Double getMaxLength() {
		return maxLength;
	}

	public void setMaxLength(Double maxLength) {
		this.maxLength = maxLength;
	}

	public Double getMinWidth() {
		return minWidth;
	}

	public void setMinWidth(Double minWidth) {
		this.minWidth = minWidth;
	}

	public Double getMaxWidth() {
		return maxWidth;
	}

	public void setMaxWidth(Double maxWidth) {
		this.maxWidth = maxWidth;
	}

//	public List<Service> getRoller() {
//		return roller;
//	}
//
//	public void setRoller(List<Service> roller) {
//		this.roller = roller;
//	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

}
