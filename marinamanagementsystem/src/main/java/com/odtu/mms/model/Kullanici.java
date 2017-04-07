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


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.NamedNativeQueries;
import org.hibernate.annotations.NamedNativeQuery;

@NamedNativeQueries({
	
	@NamedNativeQuery(
			name = "listKullanici",
			query = "select * from kullanici " ,
		        resultClass = Kullanici.class
			)
})

@Entity
@Audited
@Table(name="kullanici")
public class Kullanici extends BaseModel implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6067770109918500806L;

	@ManyToOne
	@JoinColumn(name="person_id")
	private Person person;
	
	@Column(name = "user_name", columnDefinition="text")
	@Type(type = "org.hibernate.type.TextType")
	private String username="";
	
	@Column(name = "password", columnDefinition="text")
	@Type(type = "org.hibernate.type.TextType")
	private String password="";

	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
