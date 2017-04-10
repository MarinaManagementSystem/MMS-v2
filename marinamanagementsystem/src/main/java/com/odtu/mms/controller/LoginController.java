package com.odtu.mms.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.odtu.mms.model.Kullanici;
import com.odtu.mms.model.Role;
import com.odtu.mms.service.BaseService;
import com.odtu.mms.util.MyUser;

@Controller
@RequestMapping(value="/views")
public class LoginController {
	
	@Resource(name = "baseService")
	private BaseService dao;
	
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
}
