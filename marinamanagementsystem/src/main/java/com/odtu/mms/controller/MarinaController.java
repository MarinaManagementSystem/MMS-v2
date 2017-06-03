package com.odtu.mms.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.odtu.mms.model.Berth;
import com.odtu.mms.service.BaseService;

@Controller
@RequestMapping(value="/views")
public class MarinaController {
	
	@Resource(name = "baseService")
	private BaseService dao;

//	@RequestMapping(value = "/marinaStatus", method = RequestMethod.GET)
//	public String marinaStatusGet(HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
//
//		model.addAttribute("listBerth", dao.listBerthByMarinaId(1L) );
//		
//		return "marinaStatus"; 
//	}
	
	@RequestMapping(value = "/marinaStatus", method = RequestMethod.GET)
	public String filterBerthsPost(@RequestParam(required = false, value = "status") String status,
	        						@RequestParam(required = false, value = "electricityCapacity") String electricityCapacity,
	        						@RequestParam(required = false, value = "waterCapacity") String waterCapacity,
	        						@RequestParam(required = false, value = "fuelCapacity") String fuelCapacity,
	        						@RequestParam(required = false, value = "minLength") String minLength,
	        						@RequestParam(required = false, value = "maxLength") String maxLength,
	        						@RequestParam(required = false, value = "minWidth") String minWidth,
	        						@RequestParam(required = false, value = "maxWidth") String maxWidth,
	        						HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {

		
		HashMap<String, String> filterMap = new HashMap<String, String>();
		if(status != null && status != "")
		{
			filterMap.put("status", status);
		}
		if(electricityCapacity != null && electricityCapacity != "")
		{
			filterMap.put("electricity_capacity", electricityCapacity);
		}
		if(waterCapacity != null && waterCapacity != "")
		{
			filterMap.put("water_capacity", waterCapacity);
		}
		if(fuelCapacity!= null && fuelCapacity!= "")
		{
			filterMap.put("fuel_capacity", fuelCapacity);
		}
		if(minLength!=null && minLength!= "")
		{
			filterMap.put("min_length", minLength);
		}
		if( maxLength!= null && maxLength != "")
		{
			filterMap.put("max_length", maxLength);
		}
		if(minWidth!= null && minWidth != "")
		{
			filterMap.put("min_width", minWidth);
		}
		if(maxWidth != null && maxWidth != "")
		{
			filterMap.put("max_width", maxWidth);
		}
		
		model.addAttribute("listBerth", dao.listBerthByFilteringCriterias(filterMap) );

		model.addAttribute("marinaGeneralPageActive", "active");
		model.addAttribute("marinaStatusPageActive", "active");
		
		return "marinaStatus"; 
	}
}
