package com.odtu.mms.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.odtu.mms.mail.TemplateMailCreator;
import com.odtu.mms.model.Berth;
import com.odtu.mms.model.Invoice;
import com.odtu.mms.model.Person;
import com.odtu.mms.model.Reservation;
import com.odtu.mms.model.Role;
import com.odtu.mms.model.Yacht;
import com.odtu.mms.service.BaseService;
import com.odtu.mms.util.CustomCalendarEditor;
import com.odtu.mms.util.CustomStringEditor;
import com.odtu.mms.util.MyUser;

@Controller
@RequestMapping(value="/views")
public class ReservationsController {
	
	@Resource(name = "baseService")
	private BaseService dao;
	
	@Autowired
	private MessageSource messageSource;
	
	@InitBinder
	public void initBinder(WebDataBinder binder,HttpServletRequest request) throws Exception{
		binder.registerCustomEditor(java.lang.String.class, new CustomStringEditor());
		CustomCalendarEditor ccExpireDateditor = new CustomCalendarEditor(new SimpleDateFormat("dd.MM.yyyy"), false);
		binder.registerCustomEditor(Calendar.class, ccExpireDateditor);
	}

	@RequestMapping(value = "/reservations", method = RequestMethod.GET)
	public String reservationsGet(
			@RequestParam(value = "fromDate" , required = false) String fromDate,
			@RequestParam(value = "toDateWithoutTodayLimit" , required = false) String toDate,
			@RequestParam(value = "hiddenFromDate" , required = false) String fromDateForDB,
			@RequestParam(value = "hiddenToDate" , required = false) String toDateForDB,
			@RequestParam(value = "submitCount" , required = false) Long submitCount,
			@RequestParam(value = "reservationStatusChangeAlert" , required = false) Integer reservationStatusChangeAlert,
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

		model.addAttribute("reservationStatsuAppliedInt", Reservation.RESERVATION_STATUS_APPLIED);
		model.addAttribute("reservationStatsuApprovedInt", Reservation.RESERVATION_STATUS_APPROVED);
		model.addAttribute("reservationStatsuCanceledInt", Reservation.RESERVATION_STATUS_CANCELED);
		model.addAttribute("reservationStatsuRejectedInt", Reservation.RESERVATION_STATUS_REJECTED);
		
		model.addAttribute("marinaGeneralPageActive", "active");
		model.addAttribute("reservationsPageActive", "active");
		
		model.addAttribute("reservationStatusChangeAlert", reservationStatusChangeAlert);
		
		
		return "reservations";
	}

	@RequestMapping(value = "/makeReservation", method = RequestMethod.GET)
	public String makeReservationGet(
			@RequestParam(value = "berthId" , required = false) Long berthId,
			@RequestParam(value = "fromDate" , required = false) String fromDate,
			@RequestParam(value = "toDate" , required = false) String toDate,
			HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) throws ParseException {
		
		MyUser user = (MyUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Person person = user.getPerson();
		
		if(person != null){
			Boolean waitingReservation = (Boolean) dao.getWaitingReservationByPerson(person);
			if(waitingReservation != null && waitingReservation.equals(Boolean.TRUE))
				return "redirect:marinaStatus?reservationInfoAlert=0";//bekleyen rezervaysonu varsa bir daha istek yollayamıyor
		}
			
		
		Berth berth = null;
		Reservation reservation = null;
		Yacht yacht =  null;

		SimpleDateFormat format = new SimpleDateFormat("dd.MM.yyyy", Locale.ROOT);
		Calendar calFromDate = Calendar.getInstance();
		Calendar calToDate = Calendar.getInstance();
		
		if(berthId != null)
			berth = (Berth) dao.get(Berth.class, berthId);
		else
			berth = (Berth) dao.get(Berth.class, 1L);
		
		if(fromDate != null)
			calFromDate.setTime(format.parse(fromDate));
		else
			calFromDate.setTime(format.parse("5.6.2017"));
		
		if(toDate != null)
			calToDate.setTime(format.parse(toDate));
		else
			calFromDate.setTime(format.parse("8.6.2017"));
		
		
		if(berth != null && person != null){
			reservation = new Reservation();
			
			yacht = (Yacht) dao.getYachtByPerson(person);
			if(yacht == null)
				yacht = (Yacht) dao.get(Yacht.class, 1L);
			
			reservation.setBerth(berth);
			reservation.setYacht(yacht);
			reservation.setReservationStartDate(calFromDate);
			reservation.setReservationEndDate(calToDate);
			reservation.setStatus(Boolean.FALSE);
			reservation.setReservationStatus(Reservation.RESERVATION_STATUS_APPLIED);
			reservation.setTimeStatus(Boolean.TRUE);
			
			dao.saveOrUpdate(reservation);
			
			TemplateMailCreator.sendReservationStatusInfoByUserandReservationStatus(person, Reservation.RESERVATION_STATUS_APPLIED, messageSource);
			
		}
		
		return "redirect:marinaStatus?reservationInfoAlert=1";
	}

	@RequestMapping(value = "/editReservationStatus", method = RequestMethod.GET)
	public String editReservationStatusGet(
			@RequestParam(value = "reservationId" , required = false) Long reservationId,
			@RequestParam(value = "reservationStatus" , required = false) Integer reservationStatus,
			HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) throws ParseException {
		
//		MyUser user = (MyUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Person yachtOwner = null;
		
		Reservation reservation =  null;
		
		if(reservationId != null && reservationStatus != null){
			reservation = (Reservation) dao.get(Reservation.class, reservationId);
			
			if(reservation != null){
				
				if(reservation.getYacht() != null && reservation.getYacht().getOwner() != null)
					yachtOwner = reservation.getYacht().getOwner();
				else
					yachtOwner = (Person) dao.get(Person.class, 1L);
				
				reservation.setReservationStatus(reservationStatus);
				dao.saveOrUpdate(reservation);

				TemplateMailCreator.sendReservationStatusInfoByUserandReservationStatus(yachtOwner, reservationStatus, messageSource);
				
			}
		}
		
		
		return "redirect:reservations?reservationStatusChangeAlert=1";
	}
}
