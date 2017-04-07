package com.odtu.mms.util;

import java.beans.PropertyEditorSupport;

import mva.util.MVAUtil;


public class CustomStringEditor extends PropertyEditorSupport{
	@Override
	public void setAsText(String text) throws IllegalArgumentException {
		if (text != null){
			this.setValue(MVAUtil.uStrTr(text));
		}else 
			this.setValue("");
	}

}
