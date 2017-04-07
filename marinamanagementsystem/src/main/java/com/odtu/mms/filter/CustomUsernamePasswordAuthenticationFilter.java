package com.odtu.mms.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;


public class CustomUsernamePasswordAuthenticationFilter extends  UsernamePasswordAuthenticationFilter{
	
	public CustomUsernamePasswordAuthenticationFilter(){
		super();
	}

	@Override
	public Authentication attemptAuthentication(HttpServletRequest request,
			HttpServletResponse response){
		try{
			String role = request.getParameter("role");
			if(role != null)
				request.getSession().setAttribute("role", role);
				
			Authentication auth = super.attemptAuthentication(request,response);
			
			return auth;
		}catch (BadCredentialsException e) {
			throw new BadCredentialsException("Kullanýcý Adý veya Parola Hatalý");
		}
     	
	}
	

}
