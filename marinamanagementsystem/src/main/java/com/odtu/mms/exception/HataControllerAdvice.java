package com.odtu.mms.exception;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import com.odtu.mms.service.BaseService;

@ControllerAdvice
public class HataControllerAdvice {

	@Resource(name = "baseService")
	private BaseService dao;
	
	@Autowired
	private MessageSource messageSource;

	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e,HttpServletRequest request, HttpServletResponse response) {
	
		e.printStackTrace();
		
//		MyUser user = null;
//		if(SecurityContextHolder.getContext().getAuthentication() != null)
//			user = (MyUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		Kisi kisi = null;
//		if(user != null)
//			kisi = user.getKisi();
//		
//		Hata hata = new Hata();
//		hata.setIp(request.getRemoteAddr());
//		hata.setParametre(e.getLocalizedMessage());
//		hata.setTarih(dao.getBugun());
//		hata.setKisi(kisi);
//		hata.setHataTuru(HataTuru.GENEL);
//		hata.setKod(e.getMessage());
//		hata.setAdres(request.getRequestURI().toString());
//		
//		if(Constant.SEND_HATA)
//			dao.saveOrUpdate(hata);
//
//		StringWriter sw = new StringWriter();
//		PrintWriter pw = new PrintWriter(sw);
//		e.printStackTrace(pw);
//		sw.toString(); // stack trace as a string
//		
//		if(Constant.SEND_HATA)
//			TemplateMailCreator.sendHataBilgi(kisi, request.getRequestURI(), e.getMessage(), sw.toString(), messageSource);
		
		return "hata";
	}
}
