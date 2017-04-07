package com.odtu.mms.model;

import java.io.Serializable;
import java.util.Calendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.envers.Audited;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Audited
@Table(name="yacht_service")
public class YachtService extends BaseModel implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5844850498543844552L;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="yacht_id")
	private Yacht yacht;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="service_id")
	private Service service;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="marina_id")
	private Marina marina;
	
	@Column(name = "timestamp")
	private Calendar timestamp;
	
	@Column(name = "price")
	private Double price;

	public Yacht getYacht() {
		return yacht;
	}

	public void setYacht(Yacht yacht) {
		this.yacht = yacht;
	}

	public Service getService() {
		return service;
	}

	public void setService(Service service) {
		this.service = service;
	}

	public Marina getMarina() {
		return marina;
	}

	public void setMarina(Marina marina) {
		this.marina = marina;
	}

	public Calendar getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Calendar timestamp) {
		this.timestamp = timestamp;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

}
