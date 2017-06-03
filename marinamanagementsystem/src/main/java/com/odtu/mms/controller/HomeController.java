package com.odtu.mms.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.odtu.mms.model.Person;
import com.odtu.mms.service.BaseService;
import com.odtu.mms.util.MyUser;

@Controller
@RequestMapping(value="/views")
public class HomeController {
	
	@Resource(name = "baseService")
	private BaseService dao;

	@RequestMapping(value = "/home", method = RequestMethod.GET)
//	@RequestMapping(value = {"/","/sifremiDegistir" }, method = RequestMethod.GET)
	public String homeGet(HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		
		MyUser user = (MyUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Person person = user.getPerson();
		person.getId();
		
		//GET SESSION ROLE
		if(request.isUserInRole("ROLE_SYSTEM_ADMINISTRATOR")  ){
			int i = 0;
		}else if (request.isUserInRole("ROLE_MARINA_OWNER")){
			int ii=0;
		}
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("listKullanici", dao.listKullanici());
//		model.addAttribute("listKullanici", dao.listSBFStokKalanLog());
		
		return "home"; 
	}

	@RequestMapping(value = "/aboutUs", method = RequestMethod.GET)
	public String aboutUsGet(HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		
		model.addAttribute("aboutUsPageActive", "active");
		
		return "aboutUs"; 
	}
	
}
