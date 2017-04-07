package com.odtu.mms.util;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

public class URLUtils {
	public static String addParam(HttpServletRequest request, String param,
			String value) {

		String url = request.getRequestURL().toString().replace("WEB-INF/", "")
				+ "?" + param + "=" + value;

		@SuppressWarnings("rawtypes")
		Enumeration paramNames = request.getParameterNames();

		while (paramNames.hasMoreElements()) {
			String paramName = (String) paramNames.nextElement();

			if (param.equals(paramName)) {
				continue;
			}

			url += "&" + paramName + "=" + request.getParameter(paramName);

		}

		return url;
	}
}
