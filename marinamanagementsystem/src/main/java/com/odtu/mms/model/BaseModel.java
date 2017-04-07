package com.odtu.mms.model;

import java.io.Serializable;
import java.lang.annotation.Annotation;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.search.annotations.DocumentId;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.odtu.mms.annotation.ModelClass;

@MappedSuperclass
public class BaseModel implements Serializable {

	private static final Long serialVersionUID = 1L;

	public Annotation getModelClassAnnotation() {
		return this.getClass().getAnnotation(ModelClass.class);
	}

	@JsonProperty("id")
	@Id
	@DocumentId
	@GeneratedValue(generator = "IdGenerator")
	@GenericGenerator(name = "IdGenerator", strategy = "com.odtu.mms.generator.IdGenerator")
	@Column(updatable = false, unique = true, nullable = false, name = "id")
	private Long id;
//	@Column(updatable = false, unique = true, nullable = false, name = "OID")
//	private String id;

//	public String getId() {
//		return id;
//	}
//
//	public void setId(String id) {
//		this.id = id;
//	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
