package com.odtu.mms.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mva.util.MVAUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Validator;
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
@RequestMapping(value="/pages")
public class Login2Controller {
	@Resource(name = "baseService")
	private BaseService dao;

	@Autowired
	private MessageSource messageSource;

	@Autowired
	private Validator validator;


	public static final String ERR_INVALID_USERNAME_PASSWORD = "1";
	public static final String ERR_MULTI_SESSION = "2";
	public static final String ERR_ADMIN_END_SESSION = "3";
	public static final String ERR_NOT_REGISTERED_USER = "4";
	
	@InitBinder
	public void initBinder(WebDataBinder binder,HttpServletRequest request) throws Exception{
		binder.registerCustomEditor(java.lang.String.class, new CustomStringEditor());
		//binder.registerCustomEditor(Set.class, new CustomSetEditor(Set.class,dao));
		CustomCalendarEditor ccExpireDateditor = new CustomCalendarEditor(new SimpleDateFormat("dd/MM/yyyy"), false);
		binder.registerCustomEditor(Calendar.class, ccExpireDateditor);
	}
	

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		String url="pages/login";
		
		return url; 
	}
	
	@RequestMapping(value = "/resetpassword", method = RequestMethod.GET)
	public String resetPassword(HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		String url="pages/resetpassword";
		
		
		return url; 
	}
	
	@RequestMapping(value = "/resetpassword", method = RequestMethod.POST)
	public String resetPasswordPost(HttpServletRequest request, 
			@RequestParam(value = "email", required = true) String email,
			HttpServletResponse response, Model model, Locale locale) throws Exception{
		MyUser kullanici = null;
		if(SecurityContextHolder.getContext().getAuthentication() != null)
			kullanici = (MyUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String url="pages/resetpassword";
				
		if(email == null || email.isEmpty()){
			model.addAttribute("kisiNotFoundError", messageSource.getMessage("label.resetpassword.emptyEmailError", null, locale));
			return url; 
		}
		
//		Person kisi = dao.getKisiByEposta(email);
		Person kisi = null;
		if(kisi == null){
			model.addAttribute("kisiNotFoundError", messageSource.getMessage("label.resetpassword.kisiNotFoundError", null, locale));
			return url; 
		}
		
//		String yeniParola = dao.yeniParolaOlustur();
//		
//		Kullanici kullaniciYuklenen = dao.findKullaniciByKisiId(kisi.getId());
//		kullaniciYuklenen.setParola(yeniParola);
//		
//		Calendar cal = Calendar.getInstance();
//		cal.setTime(dao.getBugun().getTime());
//		dao.saveOrUpdate(kullaniciYuklenen);
//		
//		TemplateMailCreator.sendYeniSifreToKullanici(kisi.getNameSurname(), email, yeniParola, messageSource);
		
		model.addAttribute("passwordSentMessage", messageSource.getMessage("label.resetpassword.passwordSentMessage", null, locale));
		
		return url; 
	}
	
	@RequestMapping(value = "/butonDeneme", method = RequestMethod.GET)
	public String butonDeneme(HttpServletRequest request, HttpServletResponse response, Model model, Locale locale) {
		String url="pages/butonDeneme";

		
		
		return url; 
	}
	
}





