package com.odtu.mms.controller;

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
public class ConsumptionsController {
	
	@Resource(name = "baseService")
	private BaseService dao;

	@RequestMapping(value = "/consumptions", method = RequestMethod.GET)
	public String consumptionsGet(
			@RequestParam(value = "invoiceId" , required = false) Long invoiceId,
			HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		
		if(invoiceId != null){
			model.addAttribute("invoiceId", invoiceId);
			model.addAttribute("foundConsumptions", dao.findConsumptions(invoiceId));
		}
		
		return "consumptions"; 
	}
}
