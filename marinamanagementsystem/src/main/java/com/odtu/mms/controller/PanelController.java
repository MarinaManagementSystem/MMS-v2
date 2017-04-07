package com.odtu.mms.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
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

import com.odtu.mms.model.Person;
import com.odtu.mms.service.BaseService;
import com.odtu.mms.util.CustomCalendarEditor;
import com.odtu.mms.util.CustomStringEditor;
import com.odtu.mms.util.MyUser;



@Controller
@RequestMapping(value="/pages")
public class PanelController {
	@Resource(name = "baseService")
	private BaseService dao;

	@Autowired
	private MessageSource messageSource;

	@Autowired
	private Validator validator;
	
	@InitBinder
	public void initBinder(WebDataBinder binder,HttpServletRequest request) throws Exception{
		binder.registerCustomEditor(java.lang.String.class, new CustomStringEditor());
		CustomCalendarEditor ccExpireDateditor = new CustomCalendarEditor(new SimpleDateFormat("dd.MM.yyyy"), false);
		binder.registerCustomEditor(Calendar.class, ccExpireDateditor);
	}
		
	@RequestMapping(value = "/panel", method = RequestMethod.GET)
	public String editPanelGet(Model model,  HttpServletRequest request,Locale locale) {
		String url="pages/panel";
		request.getSession();
		MyUser user = (MyUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal() ;
		Person kisi = (Person) dao.get(Person.class, user.getPerson().getId());

//		Map<String,Object> map = dao.kisiPanelOlustur(kisi, request);
		Map<String,Object> map = null;

		model.addAllAttributes(map);
		
		return url; 
	}
}
