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
@Table(name="invoice")
public class Invoice extends BaseModel implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -807231933457603258L;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="person_id")
	private Person person;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="yacht_id")
	private Yacht yacht;
	
	@Column(name = "consumption")
	private Double consumption;

	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
	}

	public Yacht getYacht() {
		return yacht;
	}

	public void setYacht(Yacht yacht) {
		this.yacht = yacht;
	}

	public Double getConsumption() {
		return consumption;
	}

	public void setConsumption(Double consumption) {
		this.consumption = consumption;
	}

}
