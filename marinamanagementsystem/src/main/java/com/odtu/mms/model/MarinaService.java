package com.odtu.mms.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.envers.Audited;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Audited
@Table(name="marina_service")
public class MarinaService extends BaseModel implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -1297127817860013090L;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="marina_id")
	private Marina marina;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="service_id")
	private Service service;
	
	@Column(name = "price")
	private Double price;

	public Marina getMarina() {
		return marina;
	}

	public void setMarina(Marina marina) {
		this.marina = marina;
	}

	public Service getService() {
		return service;
	}

	public void setService(Service service) {
		this.service = service;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

}
