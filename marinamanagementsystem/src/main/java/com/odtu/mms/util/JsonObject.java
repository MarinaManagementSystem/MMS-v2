package com.odtu.mms.util;

import java.io.Serializable;

public class JsonObject implements Serializable{

	private static final long serialVersionUID = -5935853076857757663L;

	private Long id;
	private String str;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getStr() {
		return str;
	}
	public void setStr(String str) {
		this.str = str;
	}
	
	
}
