package com.odtu.mms.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
import com.odtu.mms.model.Kullanici;
import com.odtu.mms.model.Person;
import com.odtu.mms.model.Role;
import com.odtu.mms.service.BaseService;
import com.odtu.mms.util.CustomCalendarEditor;
import com.odtu.mms.util.CustomStringEditor;
import com.odtu.mms.util.MyUser;

@Controller
@RequestMapping(value="/views")
public class LoginController {
	
	@Resource(name = "baseService")
	private BaseService dao;

	@Autowired
	private MessageSource messageSource;
	
	@InitBinder
	public void initBinder(WebDataBinder binder,HttpServletRequest request) throws Exception{
		binder.registerCustomEditor(java.lang.String.class, new CustomStringEditor());
		//binder.registerCustomEditor(Set.class, new CustomSetEditor(Set.class,dao));
		CustomCalendarEditor ccExpireDateditor = new CustomCalendarEditor(new SimpleDateFormat("dd/MM/yyyy"), false);
		binder.registerCustomEditor(Calendar.class, ccExpireDateditor);
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginGet(HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		
		return "login";
	}
	
	@RequestMapping(value = "/loginDiger", method = RequestMethod.GET)
	public String loginDigerGet(HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		
		return "loginDiger";
	}
	
	@RequestMapping(value = "/yonlendir", method = RequestMethod.GET)
	public String yonlendirGet(Kullanici kullaniciYuklenen,HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		MyUser kullanici = (MyUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		if(kullanici.getAuthorities().size() > 1)
			return "redirect:../views/listPersonRoleSelection.htm";
		
		if(request.isUserInRole(Role.ROLE_SYSTEM_ADMINISTRATOR))
			return "redirect:../views/marinaStatus.htm";
		else 
			return "redirect:../views/marinaStatus.htm";
		
	}
	
	@RequestMapping(value = "/listPersonRoleSelection", method = RequestMethod.GET)
	public String listPersonRoleSelectionGet(
			@RequestParam(value = "role" , required = false) String role,
			HttpServletRequest request, Model model, HttpServletResponse response)
	throws Exception{
		
		String url="listPersonRoleSelection";
		
		MyUser kullanici = (MyUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		if(role != null && !role.isEmpty() && role != null){
			return "redirect:../j_spring_security_check?j_username="+kullanici.getUsername()+"&j_password="+kullanici.getPassword()+"&role="+role;
		}
		
		kullanici.getAuthorities().getClass();
		model.addAttribute("listRoller", kullanici.getAuthorities());
		model.addAttribute("kullanici", kullanici);
		model.addAttribute("listTumRoller", dao.listTumRoller());
		
		return url; 
	}
	
	@RequestMapping(value = "/resetPassword", method = RequestMethod.GET)
	public String resetPassword(HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		String url="resetPassword";
		
		return url; 
	}
	
	@RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
	public String resetPasswordPost(HttpServletRequest request, 
			@RequestParam(value = "email", required = true) String email,
			HttpServletResponse response, Model model, Locale locale) throws Exception{
		
		String url="resetPassword";
		
		MyUser kullanici = null;
		if(SecurityContextHolder.getContext().getAuthentication() != null)
			kullanici = (MyUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				
		if(email == null || email.isEmpty()){
			model.addAttribute("kisiNotFoundError", true);
			return url; 
		}
		
		Person kisi = dao.getPersonByEmail(email);
		if(kisi == null){
			model.addAttribute("kisiNotFoundError", true);
			return url; 
		}
		
		String newPassword = dao.yeniParolaOlustur();
		
		Kullanici kullaniciYuklenen = dao.findKullaniciByPersonId(kisi.getId());
		kullaniciYuklenen.setPassword(newPassword);
		
		dao.saveOrUpdate(kullaniciYuklenen);
		
		TemplateMailCreator.sendYeniSifreToKullanici(kisi.getNameSurname(), email, newPassword, messageSource);
		
		model.addAttribute("passwordSentMessage", true);
		model.addAttribute("kullanici", kullanici);
		
		return url; 
	}
}
