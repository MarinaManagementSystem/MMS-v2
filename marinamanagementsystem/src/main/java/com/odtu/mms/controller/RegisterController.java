package com.odtu.mms.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.odtu.mms.editor.CustomPersonEditor;
import com.odtu.mms.mail.TemplateMailCreator;
import com.odtu.mms.model.Kullanici;
import com.odtu.mms.model.Person;
import com.odtu.mms.model.Role;
import com.odtu.mms.service.BaseService;
import com.odtu.mms.util.CustomStringEditor;

@Controller
@RequestMapping(value="/views")
public class RegisterController {
	
	@Resource(name = "baseService")
	private BaseService dao;
	
	@Autowired
	private MessageSource messageSource;

	@Autowired
	private Validator validator;
	
	@InitBinder
	public void initBinder(WebDataBinder binder,HttpServletRequest request) throws Exception{
		binder.registerCustomEditor(java.lang.String.class, new CustomStringEditor());		
		binder.registerCustomEditor(Person.class, new CustomPersonEditor(dao));
	}
	
	@ModelAttribute("personRegister")
	public Person preparePerson(@RequestParam (value="id", required=false) Long id){
		Person person = null;
		if(id != null)
			person  = (Person) dao.get(Person.class, id);
		else if(person == null) {
			person = new Person();
		}
		return person;
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String registerGet(
			@ModelAttribute("personRegister") @Valid Person person,
			HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		
//		model.addAttribute("listRole", dao.listTumRoller());
		
		return "register";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPostt(
			@ModelAttribute("personRegister") @Valid Person person,
			HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {

		Role role = (Role) dao.get(Role.class, Role.ROLE_YACHT_OWNER_ID);
		List<Role> roller = new ArrayList<Role>();
		roller.add(role);
		person.setRoller(roller);
		dao.saveOrUpdate(person);
		
		if(person != null && person.getId() != null){
			
			Kullanici kullanici = new Kullanici();
			kullanici.setPerson(person);
			kullanici.setUsername(person.getEmail());
//			kullanici.setPassword(dao.yeniParolaOlustur());
			kullanici.setPassword("12345678");
			dao.saveOrUpdate(kullanici);
			
			TemplateMailCreator.sendKullaniciKayit(kullanici, messageSource);
		}
		
		return "redirect:login.htm";
	}
}
