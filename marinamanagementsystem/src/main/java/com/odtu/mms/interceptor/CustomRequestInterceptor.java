package com.odtu.mms.interceptor;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.odtu.mms.model.Person;
import com.odtu.mms.service.BaseService;
import com.odtu.mms.util.MyUser;

public class CustomRequestInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	@Resource(name = "baseService")
	private BaseService dao;

	public BaseService getDao() {
		return dao;
	}

	public void setDao(BaseService dao) {
		this.dao = dao;
	}


	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
				
		try {
			MyUser kullanici = null;

			if (SecurityContextHolder.getContext().getAuthentication() != null) {
//				if(!handler.toString().contains("AjaxController") ){
//					
//					kullanici = (MyUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//					//List<KisiSayfaButonIzin> list = dao.listKisiSayfaButonIzinBySayfaAdVeKisiId(request.getPathInfo(),kullanici.getKisi().getId());
//					
//					//request.setAttribute("listSayfaIzin", list);
//				}
//				
				kullanici = (MyUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//				
				Person person = (Person) dao.get(Person.class, kullanici.getPerson().getId());
				request.setAttribute("kisiSessiondaBulunan", person);
//				request.setAttribute("adsoyad", person.getNameSurname());
//				
//				
			} 
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		super.postHandle(request, response, handler, modelAndView);
	}
}
