package com.odtu.mms.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.FetchType;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Type;
import org.hibernate.envers.Audited;

@Entity
@Audited
@Table(name="person")
public class Person extends BaseModel implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4443341074958721295L;

	@Column(name = "name", columnDefinition="text")
	@Type(type = "org.hibernate.type.TextType")
	private String name="";
	
	@Column(name = "surname", columnDefinition="text")
	@Type(type = "org.hibernate.type.TextType")
	private String surname="";
	
	@Column(name = "email", columnDefinition="text")
	@Type(type = "org.hibernate.type.TextType")
	private String email="";
	
	@Column(name = "phone_number")
	private Long phoneNumber;
	
	@Column(name = "status",columnDefinition="integer")
	@Type(type = "org.hibernate.type.NumericBooleanType")
	private Boolean status=true;

	@ManyToMany(targetEntity = Role.class, fetch = FetchType.EAGER,cascade=CascadeType.ALL)
	@JoinTable(name = "person_role", joinColumns = @JoinColumn(name = "person_id"), inverseJoinColumns = @JoinColumn(name = "role_id"))
	private List<Role> roller = new ArrayList<Role>();
	
	@OneToMany(mappedBy = "owner")
	private List<Yacht> listYacht = new ArrayList<Yacht>();

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getNameSurname(){
		return name + " "+ surname;
	}

	public List<Role> getRoller() {
		return roller;
	}

	public void setRoller(List<Role> roller) {
		this.roller = roller;
	}

	public Long getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(Long phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	public List<Yacht> getListYacht() {
		return listYacht;
	}

	public void setListYacht(List<Yacht> listYacht) {
		this.listYacht = listYacht;
	}
	
//	@Column(name = "phone_number", columnDefinition="text")
//	@Type(type = "org.hibernate.type.TextType")
//	private String phoneNumber="";

}
