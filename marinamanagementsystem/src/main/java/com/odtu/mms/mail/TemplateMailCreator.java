package com.odtu.mms.mail;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.runtime.RuntimeConstants;
import org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.ui.velocity.VelocityEngineUtils;

import com.odtu.mms.model.Kullanici;
import com.odtu.mms.model.Person;
import com.odtu.mms.model.Reservation;
import com.odtu.mms.util.Constant;


public class TemplateMailCreator {
    private static VelocityEngine velocityEngine;
	public static SimpleDateFormat format = new SimpleDateFormat("dd.MM.yyyy");

    public static void sendKullaniciKayit(Kullanici kullanici,MessageSource messageSource){
		Map model  = new HashMap();
		Locale locale = LocaleContextHolder.getLocale();

		model.put("uygulamaAdresi", Constant.UYGULAMA_ADRESI);
		model.put("adSoyad", kullanici.getPerson().getNameSurname());
		model.put("kullaniciAdi", kullanici.getUsername());
		model.put("parola", kullanici.getPassword());
		model.put("tiklayiniz", "click here");
		model.put("sayinLabel", "Dear");
		model.put("kullaniciGirisTitle", "User Information");
		model.put("kullaniciAdiLabel", "username");
		model.put("parolaLabel", "password");
		model.put("appLabel", "If you like to login now,");
		         
        try{
        	VelocityEngine velocityEngine = new VelocityEngine();
        	velocityEngine.setProperty(RuntimeConstants.RESOURCE_LOADER, "classpath");
        	velocityEngine.setProperty("classpath.resource.loader.class", ClasspathResourceLoader.class.getName());
        	velocityEngine.init();
        	String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "com/odtu/mms/velocity/kullaniciKayit.vm","UTF-8", model);
        	MailSender.gonder(kullanici.getPerson().getEmail(), "New User Information", text);
        }catch(Exception e){
        	e.printStackTrace();
        }
	}
    
    public static void sendYeniSifreToKullanici(String personNameSurname,String email,String newPassword,MessageSource messageSource){
    	Map model  = new HashMap();
		Locale locale = LocaleContextHolder.getLocale();
		
		model.put("dear", "Dear");
    	model.put("personNameSurname", personNameSurname);
    	
    	model.put("body","Your password has been renewed. Change your password when you log in. New password");
    	model.put("password",newPassword);
    	
    	try{
			VelocityEngine velocityEngine = new VelocityEngine();
			velocityEngine.setProperty(RuntimeConstants.RESOURCE_LOADER, "classpath");
			velocityEngine.setProperty("classpath.resource.loader.class", ClasspathResourceLoader.class.getName());
			velocityEngine.init();
			String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "com/odtu/mms/velocity/sendNewPassword.vm", "UTF-8", model);
			MailSender.gonder(email,"Password Reset Info", text);
		}catch(Exception e){
			e.printStackTrace();
		}
    }

    public static void sendReservationStatusInfoByUserandReservationStatus(Person person, Integer reservationStatus,MessageSource messageSource){
    	Map model  = new HashMap();
		Locale locale = LocaleContextHolder.getLocale();
		
		model.put("dear", "Dear");
    	model.put("personNameSurname", person.getNameSurname());
    	
    	if(reservationStatus.equals(Reservation.RESERVATION_STATUS_APPLIED))
    		model.put("body","Your reservation application is recieved. You will be informed when your application is evaluated.");
    	else if(reservationStatus.equals(Reservation.RESERVATION_STATUS_APPROVED))
    		model.put("body","Your reservation application is approved.");
    	else if(reservationStatus.equals(Reservation.RESERVATION_STATUS_REJECTED))
    		model.put("body","Your reservation application is rejected.");
    	else if(reservationStatus.equals(Reservation.RESERVATION_STATUS_CANCELED))
    		model.put("body","Your reservation application is canceled.");
    	
    	try{
			VelocityEngine velocityEngine = new VelocityEngine();
			velocityEngine.setProperty(RuntimeConstants.RESOURCE_LOADER, "classpath");
			velocityEngine.setProperty("classpath.resource.loader.class", ClasspathResourceLoader.class.getName());
			velocityEngine.init();
			String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "com/odtu/mms/velocity/sendReservationStatusInfo.vm", "UTF-8", model);
			MailSender.gonder(person.getEmail(),"Reservation Info", text);
		}catch(Exception e){
			e.printStackTrace();
		}
    }
}
