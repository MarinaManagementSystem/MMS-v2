package com.odtu.mms.service;


import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import microsoft.exchange.webservices.data.AccountIsLockedException;
import mva.util.MVAUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.dao.DataAccessException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.odtu.mms.model.Kullanici;



@Service("userDetailsService")
public class UserDetailsServiceImpl implements UserDetailsService {
	@Autowired
	private BaseService dao;

	@Autowired
	private Assembler assembler;
	
	@Autowired
	private MessageSource messageSource;

	@Transactional(readOnly = false)
	public UserDetails loadUserByUsername(String username){
		try{
			Kullanici kullanici = dao.findKullaniciByKullaniciAdi(username);
			ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
			HttpServletRequest request= attr.getRequest();
			Locale locale = LocaleContextHolder.getLocale();
			if(kullanici != null && !kullanici.getPassword().equals(request.getParameter("j_password"))){
				String error = "Incorrect login information";
				request.getSession().setAttribute("error", 1);
				request.getSession().setAttribute("errorLogin", 1);
				request.getSession().removeAttribute("passivePerson");
				throw new BadCredentialsException("2");
			}
			if (kullanici == null){
				String error = "Incorrect login information";
				request.getSession().setAttribute("error", 1);
				request.getSession().setAttribute("errorLogin", 1);
				request.getSession().removeAttribute("passivePerson");
				throw new UsernameNotFoundException("3");
			}
			if(kullanici != null && kullanici.getPerson() != null && kullanici.getPerson().getStatus().equals(Boolean.FALSE)){
				request.getSession().setAttribute("passivePerson", 1);
				request.getSession().setAttribute("errorLogin", 1);
				request.getSession().removeAttribute("error");
				throw new BadCredentialsException("4");
			}
			
			request.getSession().removeAttribute("error");
			request.getSession().removeAttribute("passivePerson");
			request.getSession().removeAttribute("errorLogin");
			
			return assembler.buildUserFromUserEntity(kullanici);
		
		}catch (BadCredentialsException e) {
//			hataliGirisKaydiYap(username);
			return null;
		}catch (LockedException e) {
			throw new LockedException("1");
		}catch (UsernameNotFoundException e) {
			throw new UsernameNotFoundException("3");
		}
		
	}
	
	
//	public void hataliGirisKaydiYap(String kullaniciAdi) {
//		if(!MVAUtil.isEmpty(kullaniciAdi)){
//			Kullanici hataliKullanici= dao.findKullaniciByKullaniciAdi(kullaniciAdi);
//			Integer hataliGirisSayi = hataliKullanici.getHataliGirisSayi();
//			if(hataliGirisSayi == null){
//				hataliGirisSayi=0;
//			} 
//			hataliGirisSayi += 1;
//			hataliKullanici.setHataliGirisSayi(hataliGirisSayi);
//			if(hataliGirisSayi > Constant.HATALI_PAROLA_GIRIS_SAYISI_IZIN_VERILEN){ 
//				hataliKullanici.setHesapKilitli(true); 
//			}
//			dao.saveOrUpdate(hataliKullanici);
//		}
//	}
}
