package com.odtu.mms.controller;

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
public class ProcurementHistoryController {
	
	@Resource(name = "baseService")
	private BaseService dao;

	@RequestMapping(value = "/procurementHistory", method = RequestMethod.GET)
	public String marinaStatusGet(
			@RequestParam(value = "hiddenFromDate" , required = false) Date formattedFromDateForDB,
			@RequestParam(value = "hiddenToDate" , required = false) Date formattedToDateForDB,
			@RequestParam(value = "fromDate" , required = false) Date fromDate,
			@RequestParam(value = "toDate" , required = false) Date toDate,
			HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		
		if(formattedFromDateForDB != null && formattedToDateForDB != null && fromDate != null && toDate != null){
			model.addAttribute("foundInvoices", dao.findInvoices(formattedFromDateForDB, formattedToDateForDB));
			
			return "redirect:procurementHistory?fromDate="+fromDate+"toDate="+toDate;
		}
		
		return "procurementHistory";
		//return null;
	}
}
