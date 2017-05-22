package com.odtu.mms.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.envers.Audited;

@Entity
@Audited
@Table(name="berth_service")
public class BerthService extends BaseModel implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1409911653003057634L;

//	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="berth_id")
	private Berth berth;

//	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="service_id")
	private GeneralService service;
	
	@Column(name = "price")
	private Double price;

	public Berth getBerth() {
		return berth;
	}

	public void setBerth(Berth berth) {
		this.berth = berth;
	}

	public GeneralService getService() {
		return service;
	}

	public void setService(GeneralService service) {
		this.service = service;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
	
}
