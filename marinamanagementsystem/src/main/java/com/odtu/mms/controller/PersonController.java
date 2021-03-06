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
import org.springframework.security.core.context.SecurityContextHolder;
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
import com.odtu.mms.editor.CustomRoleEditor;
import com.odtu.mms.mail.TemplateMailCreator;
import com.odtu.mms.model.Kullanici;
import com.odtu.mms.model.Person;
import com.odtu.mms.model.Role;
import com.odtu.mms.service.BaseService;
import com.odtu.mms.util.CustomStringEditor;
import com.odtu.mms.util.MyUser;

import mva.util.MVAUtil;

@Controller
@RequestMapping(value="/views")
public class PersonController {
	
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
		binder.registerCustomEditor(Role.class, new CustomRoleEditor(dao));
	}
	
	@ModelAttribute("editPersonInformation")
	public Person preparePerson(@RequestParam (value="id", required=false) Long id){
		Person person = null;
		if(id != null)
			person  = (Person) dao.get(Person.class, id);
		else if(person == null) {
			person = new Person();
		}
		return person;
	}
	
	@RequestMapping(value = "/editPersonInfo", method = RequestMethod.GET)
	public String editPersonInfoGet(
			@ModelAttribute("editPersonInformation") @Valid Person person,
			@RequestParam (value="savedPerson", required=false) Integer savedPerson,
			HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		
		MyUser user = (MyUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Person personSession = user.getPerson();

		if(request.isUserInRole("ROLE_SYSTEM_ADMINISTRATOR")  ){
			
			if(person != null && person.getId() != null)
				model.addAttribute("newPerson", false);
			else 
				model.addAttribute("newPerson", true);
			
		}else {
			
			model.addAttribute("editPersonInformation", personSession);
			model.addAttribute("newPerson", false);
		}
		
		model.addAttribute("listRole", dao.listTumRoller());
		model.addAttribute("savedPerson", savedPerson);
		
		return "editPersonInfo";
	}
	
	@RequestMapping(value = "/editPersonInfo", method = RequestMethod.POST)
	public String personInfoFormPost(
			@ModelAttribute("editPersonInformation") @Valid Person person,
			@RequestParam (value="newPerson", required=false) Boolean newPerson,
			HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		
		dao.saveOrUpdate(person);
		
		if(newPerson != null && newPerson != null && newPerson.equals(Boolean.TRUE)){
			
			Kullanici kullanici = new Kullanici();
			kullanici.setPerson(person);
			kullanici.setUsername(person.getEmail());
			kullanici.setPassword(dao.yeniParolaOlustur());
//			kullanici.setPassword("1234");
			dao.saveOrUpdate(kullanici);
			
			TemplateMailCreator.sendKullaniciKayit(kullanici, messageSource);
		}
		
		return "redirect:editPersonInfo.htm?id="+person.getId()+"&savedPerson=1";
	}
	
	@RequestMapping(value = "/updatePersonStatus", method = RequestMethod.GET)
	public String deletePersonGet(
			@ModelAttribute("editPersonInformation") @Valid Person person,
			HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {

		if(person != null && person.getId() != null){
			if(person.getStatus() != null && person.getStatus().equals(Boolean.TRUE))
				person.setStatus(Boolean.FALSE);
			else if(person.getStatus() != null && person.getStatus().equals(Boolean.FALSE))
				person.setStatus(Boolean.TRUE);
			dao.saveOrUpdate(person);
			return "redirect:systemUsers.htm?updatedStatus="+1;
		}else 
			return "redirect:systemUsers.htm?updatedStatus="+0;
	}
}
