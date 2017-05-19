package com.odtu.mms.model;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.odtu.mms.service.BaseService;

@Controller
@RequestMapping(value="/views")
public class ConsumptionsController {
	
	@Resource(name = "baseService")
	private BaseService dao;

	@RequestMapping(value = "/consumptions", method = RequestMethod.GET)
	public String marinaStatusGet(
			@RequestParam(value = "fromDate" , required = false) @DateTimeFormat(pattern="dd.MM.yyyy") Date fromDate,
			@RequestParam(value = "toDate" , required = false) @DateTimeFormat(pattern="dd.MM.yyyy") Date toDate,
			HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		
		if(fromDate != null && toDate != null){
			model.addAttribute("foundInvoices", dao.findInvoices(fromDate, toDate));
		}
		
		return "redirect:consumptions?fromDate="+fromDate+"toDate="+toDate; 
	}
}
