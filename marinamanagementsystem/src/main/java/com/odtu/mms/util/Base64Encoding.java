package com.odtu.mms.util;

import java.io.IOException;
import java.util.Enumeration;
import java.util.Properties;

import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.util.ObjectUtils;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;


public class Base64Encoding  extends PropertyPlaceholderConfigurer {


	public static String encode(String str) {
	    BASE64Encoder encoder = new BASE64Encoder();
	    str = new String(encoder.encodeBuffer(str.getBytes()));
	    return str;
	}

	public static String decode(String str) {
	    BASE64Decoder decoder = new BASE64Decoder();
	    try {
	        str = new String(decoder.decodeBuffer(str));
	    } catch (IOException e) {
	        e.printStackTrace();
	    }       
	    return str;
	}
	
	@Override
	 protected void convertProperties(Properties props){
		Enumeration<?> propertyNames = props.propertyNames();
		  while (propertyNames.hasMoreElements()) {
		   String propertyName = (String) propertyNames.nextElement();
		   String propertyValue = props.getProperty(propertyName);
		   
		   String convertedValue = decode(propertyValue);
		   if (!ObjectUtils.nullSafeEquals(propertyValue, convertedValue)) {
		    props.setProperty(propertyName, convertedValue);
		   }
		  }
	}
}
