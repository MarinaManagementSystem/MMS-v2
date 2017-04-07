package com.odtu.mms.editor;

import java.beans.PropertyEditorSupport;

import org.springframework.beans.SimpleTypeConverter;

import com.odtu.mms.model.Role;
import com.odtu.mms.service.BaseService;

import mva.util.MVAUtil;

public class CustomRoleEditor  extends PropertyEditorSupport{


	private BaseService dao;
	private SimpleTypeConverter typeConverter = new SimpleTypeConverter();


	public CustomRoleEditor (BaseService dao) {
		this.dao = dao;
	}

	@Override
	public String getAsText() {
		Object obj = getValue();
		if( obj == null ) {
			return "";
		}
		if( obj instanceof Role ) {
			Role domainObject = ( Role ) obj;
			return typeConverter.convertIfNecessary(domainObject.getId(), String.class );
		}
		return "";

	}


	@Override
	public void setAsText(String text) throws IllegalArgumentException {
		if (text != null){
			Role role = (Role) dao.get(Role.class, MVAUtil.uLong(text));
			this.setValue(role);
		}else 
			this.setValue(null);
	}
}
