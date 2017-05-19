package com.odtu.mms.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.odtu.mms.service.BaseService;
import com.odtu.mms.util.CustomCalendarEditor;
import com.odtu.mms.util.CustomStringEditor;

@Controller
@RequestMapping(value="/views")
public class ProcurementHistoryController {
	
	@Resource(name = "baseService")
	private BaseService dao;
	
	@InitBinder
	public void initBinder(WebDataBinder binder,HttpServletRequest request) throws Exception{
		binder.registerCustomEditor(java.lang.String.class, new CustomStringEditor());
		CustomCalendarEditor ccExpireDateditor = new CustomCalendarEditor(new SimpleDateFormat("dd.MM.yyyy"), false);
		binder.registerCustomEditor(Calendar.class, ccExpireDateditor);
	}

	@RequestMapping(value = "/procurementHistory", method = RequestMethod.GET)
	public String marinaStatusGet(
			@RequestParam(value = "fromDate" , required = false) String fromDate,
			@RequestParam(value = "toDate" , required = false) String toDate,
			@RequestParam(value = "hiddenFromDate" , required = false) String fromDateForDB,
			@RequestParam(value = "hiddenToDate" , required = false) String toDateForDB,
			@RequestParam(value = "submitCount" , required = false) Long submitCount,
			HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		
		if(fromDate != null && fromDateForDB != null && toDate != null && toDateForDB != null && submitCount != null){
			
			submitCount++;
			model.addAttribute("foundInvoices", dao.findInvoices(fromDateForDB, toDateForDB));
			
			return "redirect:procurementHistory?fromDate="+fromDate+"&toDate="+toDate+"&submitCount="+submitCount;
		}
		
		return "procurementHistory";
		//return null;
	}
}
