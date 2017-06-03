package com.odtu.mms.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.odtu.mms.service.BaseService;

@Controller
@RequestMapping(value="/views")
public class ContactUsController {
	
	@Resource(name = "baseService")
	private BaseService dao;

	@RequestMapping(value = "/contactUs", method = RequestMethod.GET)
	public String contactUsGet(HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {

		model.addAttribute("contactUsPageActive", "active");
		model.addAttribute("contactUsLinkPageActive", "active");
		
		return "contactUs"; 
	}
}
