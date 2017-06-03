package com.odtu.mms.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.odtu.mms.service.BaseService;

@Controller
@RequestMapping(value="/views")
public class SystemUsersController {
	
	@Resource(name = "baseService")
	private BaseService dao;

	@RequestMapping(value = "/systemUsers", method = RequestMethod.GET)
	public String homeGet(

			@RequestParam (value="updatedStatus", required=false) Integer updatedStatus,
			HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("listPerson", dao.listPerson());
		model.addAttribute("updatedStatus", updatedStatus);
		
		model.addAttribute("systemUsersPageActive", "active");
		
		return "systemUsers"; 
	}
	
}
