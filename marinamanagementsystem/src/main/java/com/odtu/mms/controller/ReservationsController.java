package com.odtu.mms.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.odtu.mms.model.Invoice;
import com.odtu.mms.model.Person;
import com.odtu.mms.model.Reservation;
import com.odtu.mms.model.Role;
import com.odtu.mms.service.BaseService;
import com.odtu.mms.util.CustomCalendarEditor;
import com.odtu.mms.util.CustomStringEditor;
import com.odtu.mms.util.MyUser;

@Controller
@RequestMapping(value="/views")
public class ReservationsController {
	
	@Resource(name = "baseService")
	private BaseService dao;
	
	@InitBinder
	public void initBinder(WebDataBinder binder,HttpServletRequest request) throws Exception{
		binder.registerCustomEditor(java.lang.String.class, new CustomStringEditor());
		CustomCalendarEditor ccExpireDateditor = new CustomCalendarEditor(new SimpleDateFormat("dd.MM.yyyy"), false);
		binder.registerCustomEditor(Calendar.class, ccExpireDateditor);
	}

	@RequestMapping(value = "/reservations", method = RequestMethod.GET)
	public String reservationsGet(
			@RequestParam(value = "fromDate" , required = false) String fromDate,
			@RequestParam(value = "toDate" , required = false) String toDate,
			@RequestParam(value = "hiddenFromDate" , required = false) String fromDateForDB,
			@RequestParam(value = "hiddenToDate" , required = false) String toDateForDB,
			@RequestParam(value = "submitCount" , required = false) Long submitCount,
			HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		
		if(fromDate != null && fromDateForDB != null && toDate != null && toDateForDB != null && submitCount != null){
			
			MyUser user = (MyUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			Person person = user.getPerson();
			Long userId = person.getId();
			
			String userRole = "";
			Long userRoleId;
			
			// Get session role and generate the query at Base Service accordingly
			if (request.isUserInRole(Role.ROLE_SYSTEM_ADMINISTRATOR)) {
				userRoleId = Role.ROLE_SYSTEM_ADMINISTRATOR_ID;
				userRole = "System Administrator";
			} else if (request.isUserInRole(Role.ROLE_MARINA_OWNER)) {
				userRoleId = Role.ROLE_MARINA_OWNER_ID;
				userRole = "Marina Owner";
			} else {
				userRoleId = Role.ROLE_YACHT_OWNER_ID;
				userRole = "Yacht Owner";
			}
			
			model.addAttribute("foundReservations", dao.findReservations(fromDateForDB, toDateForDB, userId, userRole, userRoleId));
			model.addAttribute("fromDate", fromDate);
			model.addAttribute("toDate", toDate);
			model.addAttribute("userRole", userRole);
			
			// Increment the submitCount so that the page can understand that a query was run
			submitCount++;
			model.addAttribute("submitCount", submitCount);
		}

		model.addAttribute("marinaGeneralPageActive", "active");
		model.addAttribute("reservationsPageActive", "active");
		
		
		return "reservations";
	}

	@RequestMapping(value = "/makeReservation", method = RequestMethod.GET)
	public String makeReservationGet(
			@RequestParam(value = "berthId" , required = false) Long berthId,
			@RequestParam(value = "fromDate" , required = false) String fromDate,
			@RequestParam(value = "toDate" , required = false) String toDate,
			HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		
		return "makeReservation";
	}
}
