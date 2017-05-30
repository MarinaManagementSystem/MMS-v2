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
		model.put("tiklayiniz", "tıklayınız");
		model.put("sayinLabel", "Sayın");
		model.put("kullaniciKayitBilgiLabel", "Kullanıcı kayıt bilgileri");
		model.put("kullaniciGirisTitle", "Kayıt Bilgileri");
		model.put("kullaniciAdiLabel", "kullanıcı Adı");
		model.put("parolaLabel", "parola");
		model.put("appLabel", "marinamanagementsystem");
		         
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
		
		model.put("dear", "Sayın");
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
}
