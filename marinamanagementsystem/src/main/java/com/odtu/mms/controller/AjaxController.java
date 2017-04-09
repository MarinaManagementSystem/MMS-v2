package com.odtu.mms.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.odtu.mms.mail.TemplateMailCreator;
import com.odtu.mms.service.BaseService;
import com.odtu.mms.util.JsonObject;
import com.odtu.mms.util.MyUser;

import mva.util.MVAUtil;

@Controller
@RequestMapping(value="/views")
public class AjaxController {

	@Resource(name = "baseService")
	private BaseService dao;
	
	@Autowired
	private MessageSource messageSource;

	@RequestMapping(value = {"/ajaxKullaniciAdiUygunMu"}, method = RequestMethod.GET)
	public @ResponseBody Boolean ajaxKullaniciAdiUygunMu(
			@RequestParam(value = "kullaniciAdi", required = true) String kullaniciAdi, 
			Model model, HttpServletRequest request, HttpServletResponse response, Locale locale) 
	throws Exception{

		return dao.kullaniciAdiUygunMu(kullaniciAdi);
	}

//	@RequestMapping(value = {"/ajaxBelgeKoduOlustur"}, method = RequestMethod.GET)
//	public @ResponseBody String ajaxBelgeKoduOlustur(
//			@RequestParam(value = "kurulusDenetimId", required = true) Long kurulusDenetimId, 
//			@RequestParam(value = "belgeTuruId", required = true) Long belgeTuruId, 
//			Model model, HttpServletRequest request, HttpServletResponse response, Locale locale) 
//	throws Exception{
//
//		return dao.belgeKoduUretYeni(kurulusDenetimId, belgeTuruId);
//	}
	
	
//	@RequestMapping(value = "/loadAkreditasyonTuru", method = RequestMethod.GET)
//	public  @ResponseBody List<AkreditasyonTuru> loadAkreditasyonTuru(
//			@RequestParam(value="kayit", required=false) Boolean kayit,			
//			Model model,  HttpServletRequest request,Locale locale) {
//		
//		List<AkreditasyonTuru> list = dao.listAkreditasyonTuruByDurumandKayit(Boolean.TRUE, kayit);
//		
//		return list; 
//	}
	
//	@RequestMapping(value = "/loadKurulusDenetimTakvim", method = RequestMethod.GET)
//	public  @ResponseBody List<Object[]> loadKurulusDenetimTakvim(
//			@RequestParam(value="calendarMonth", required=true) int calendarMonth,
//			@RequestParam(value="calendarYear", required=true) int calendarYear,
//			Model model,  HttpServletRequest request,Locale locale) 
//	throws Exception{
//
//		List<Object []> listArray = null;
//
//		if(request.isUserInRole("ROL_PLANLAMA_SORUMLUSU") || request.isUserInRole("ROL_BELGELENDIRME_MUDURU")){
//			listArray = dao.listurulusDenetimTakvimByYearandMonth(calendarYear, calendarMonth);
//		}
//
//		return listArray; 
//	}
	
//	@RequestMapping(value = "/kayitliBasvuruDosyaIncelemeUcreti", method = RequestMethod.GET)
//	public  @ResponseBody BasvuruDosyaIncelemeUcreti kayitliBasvuruDosyaIncelemeUcretiGet(
//			@RequestParam(value="id", required=true) Long id,
//			Model model,  HttpServletRequest request,Locale locale) {
//		
//		BasvuruDosyaIncelemeUcreti basvuruDosyaIncelemeUcreti = (BasvuruDosyaIncelemeUcreti) dao.get(BasvuruDosyaIncelemeUcreti.class, id);		
//		
//		return basvuruDosyaIncelemeUcreti; 
//	}
	
}
