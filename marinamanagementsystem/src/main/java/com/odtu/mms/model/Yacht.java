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
@Table(name="yacht")
public class Yacht extends BaseModel implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8645828621271473526L;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="owner_id")
	private Person owner;
	
	@Column(name = "name", columnDefinition="text")
	@Type(type = "org.hibernate.type.TextType")
	private String name="";
	
	@Column(name = "width")
	private Double width;
	
	@Column(name = "length")
	private Double length;
	
	@Column(name = "electric_capacity")
	private Double electricCapacity;
	
	@Column(name = "fuel_capacity")
	private Double fuelCapacity;
	
	@Column(name = "water_capacity")
	private Double waterCapacity;

	public Person getOwner() {
		return owner;
	}

	public void setOwner(Person owner) {
		this.owner = owner;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Double getWidth() {
		return width;
	}

	public void setWidth(Double width) {
		this.width = width;
	}

	public Double getLength() {
		return length;
	}

	public void setLength(Double length) {
		this.length = length;
	}

	public Double getElectricCapacity() {
		return electricCapacity;
	}

	public void setElectricCapacity(Double electricCapacity) {
		this.electricCapacity = electricCapacity;
	}

	public Double getFuelCapacity() {
		return fuelCapacity;
	}

	public void setFuelCapacity(Double fuelCapacity) {
		this.fuelCapacity = fuelCapacity;
	}

	public Double getWaterCapacity() {
		return waterCapacity;
	}

	public void setWaterCapacity(Double waterCapacity) {
		this.waterCapacity = waterCapacity;
	}

}
