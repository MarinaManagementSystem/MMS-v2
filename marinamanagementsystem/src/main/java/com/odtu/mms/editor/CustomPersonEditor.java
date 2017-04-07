package com.odtu.mms.editor;

import java.beans.PropertyEditorSupport;

import org.springframework.beans.SimpleTypeConverter;

import com.odtu.mms.model.Person;
import com.odtu.mms.service.BaseService;

import mva.util.MVAUtil;

public class CustomPersonEditor  extends PropertyEditorSupport{


	private BaseService dao;
	private SimpleTypeConverter typeConverter = new SimpleTypeConverter();


	public CustomPersonEditor (BaseService dao) {
		this.dao = dao;
	}

	@Override
	public String getAsText() {
		Object obj = getValue();
		if( obj == null ) {
			return "";
		}
		if( obj instanceof Person ) {
			Person domainObject = ( Person ) obj;
			return typeConverter.convertIfNecessary(domainObject.getId(), String.class );
		}
		return "";

	}


	@Override
	public void setAsText(String text) throws IllegalArgumentException {
		if (text != null){
			Person person = (Person) dao.get(Person.class, MVAUtil.uLong(text));
			this.setValue(person);
		}else 
			this.setValue(null);
	}
}
