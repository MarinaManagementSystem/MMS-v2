package com.odtu.mms.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
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

import com.odtu.mms.model.Berth;
import com.odtu.mms.service.BaseService;
import com.odtu.mms.util.CustomCalendarEditor;
import com.odtu.mms.util.CustomStringEditor;

@Controller
@RequestMapping(value="/views")
public class MarinaController {
	
	@Resource(name = "baseService")
	private BaseService dao;
	
	@InitBinder
	public void initBinder(WebDataBinder binder,HttpServletRequest request) throws Exception{
		binder.registerCustomEditor(java.lang.String.class, new CustomStringEditor());
		CustomCalendarEditor ccExpireDateditor = new CustomCalendarEditor(new SimpleDateFormat("dd.MM.yyyy"), false);
		binder.registerCustomEditor(Calendar.class, ccExpireDateditor);
	}

	
	@RequestMapping(value = "/marinaStatus", method = RequestMethod.GET)
	public String filterBerthsPost(@RequestParam(required = false, value = "status") String status,
	        						@RequestParam(required = false, value = "electricityCapacity") String electricityCapacity,
	        						@RequestParam(required = false, value = "waterCapacity") String waterCapacity,
	        						@RequestParam(required = false, value = "fuelCapacity") String fuelCapacity,
	        						@RequestParam(required = false, value = "minLength") String minLength,
	        						@RequestParam(required = false, value = "maxLength") String maxLength,
	        						@RequestParam(required = false, value = "minWidth") String minWidth,
	        						@RequestParam(required = false, value = "maxWidth") String maxWidth,
	        						@RequestParam(value = "fromDate" , required = false) String fromDate,
	        						@RequestParam(value = "toDate" , required = false) String toDate,
	        						@RequestParam(value = "reservationInfoAlert" , required = false) Integer reservationInfoAlert,
	        						HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {

		
		HashMap<String, String> filterMap = new HashMap<String, String>();
		if(status != null && status != "" && !status.isEmpty() )
		{
			filterMap.put("status", status);
		}
		if(electricityCapacity != null && electricityCapacity != "" && !electricityCapacity.isEmpty())
		{
			filterMap.put("electricity_capacity", electricityCapacity);
		}
		if(waterCapacity != null && waterCapacity != "" && !waterCapacity.isEmpty())
		{
			filterMap.put("water_capacity", waterCapacity);
		}
		if(fuelCapacity!= null && fuelCapacity!= "" && !fuelCapacity.isEmpty())
		{
			filterMap.put("fuel_capacity", fuelCapacity);
		}
		if(minLength!=null && minLength!= "" && !minLength.isEmpty())
		{
			filterMap.put("min_length", minLength);
		}
		if( maxLength!= null && maxLength != "" && !maxLength.isEmpty())
		{
			filterMap.put("max_length", maxLength);
		}
		if(minWidth!= null && minWidth != "" && !minWidth.isEmpty())
		{
			filterMap.put("min_width", minWidth);
		}
		if(maxWidth != null && maxWidth != "" && !maxWidth.isEmpty())
		{
			filterMap.put("max_width", maxWidth);
		}
		if(fromDate != null && fromDate != "" && !fromDate.isEmpty())
		{
			filterMap.put("reservation_start_date", fromDate);
		}
		if(toDate != null && toDate != "" && !toDate.isEmpty())
		{
			filterMap.put("reservation_end_date", toDate);
		}
		
		model.addAttribute("listBerth", dao.listBerthByFilteringCriterias(filterMap) );
		
		model.addAttribute("hFromDate", fromDate);
		model.addAttribute("hToDate", toDate);
		model.addAttribute("reservationInfoAlert", reservationInfoAlert);
		
		return "marinaStatus"; 
	}
}
