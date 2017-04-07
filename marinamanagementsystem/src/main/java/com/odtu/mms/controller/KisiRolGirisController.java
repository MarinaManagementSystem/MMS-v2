package com.odtu.mms.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.hibernate.SessionFactory;
import org.hsqldb.Collation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Scope;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Validator;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.asprise.util.tiff.E;
import com.odtu.mms.service.BaseService;
import com.odtu.mms.util.MyUser;

@Controller
@RequestMapping(value="/pages")
public class KisiRolGirisController {

	@Resource(name = "baseService")
	private BaseService dao;

	@Resource(name = "sessionFactory")
	private SessionFactory sessionFactory;

	@Autowired
	private MessageSource messageSource;

	@Autowired
	private Validator validator;
	
	@RequestMapping(value = "/listKisiRollerGiris", method = RequestMethod.GET)
	public String listKisiRollerGirisGet(@RequestParam(value = "rol" , required = false) String rol,
			HttpServletRequest request, Model model, HttpServletResponse response)
	throws Exception{
		String url="pages/listKisiRollerGiris";
		MyUser kullanici = (MyUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		if(rol != null && !rol.isEmpty() && rol != null){
			return "redirect:../../j_spring_security_check?j_username="+kullanici.getUsername()+"&j_password="+kullanici.getPassword()+"&role="+rol;
		}
		kullanici.getAuthorities().getClass();
		//kullanici.getAuthorities().add(col.);
		model.addAttribute("listRoller", kullanici.getAuthorities());
		model.addAttribute("kullanici", kullanici);
//		model.addAttribute("listTumRoller", dao.listTumRoller()); TODO AC
		return url; 
	}

}
