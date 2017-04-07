package com.odtu.mms.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Type;
import org.hibernate.envers.Audited;

@Entity
@Audited
@Table(name="service")
public class Service extends BaseModel implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6044980787086727851L;
	
	@Column(name = "name", columnDefinition="text")
	@Type(type = "org.hibernate.type.TextType")
	private String name="";
	
	@Column(name = "status",columnDefinition="integer")
	@Type(type = "org.hibernate.type.NumericBooleanType")
	private Boolean status;

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

}
