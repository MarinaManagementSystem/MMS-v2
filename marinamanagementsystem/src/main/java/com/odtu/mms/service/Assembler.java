package com.odtu.mms.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.odtu.mms.model.Kullanici;
import com.odtu.mms.model.Role;
import com.odtu.mms.util.MyUser;


@Service("assembler")
@Transactional(readOnly = true)
@Repository
public class Assembler {
	
	@Resource(name = "baseService")
	private BaseService dao;
	
	@Autowired
	private HttpServletRequest request;
	
	public User buildUserFromUserEntity(Kullanici kullanici) {
		String kullaniciAdi = kullanici.getUsername();
		String parola = kullanici.getPassword();
		boolean enabled = true;
		boolean accountNonExpired = true;
		boolean credentialsNonExpired = true;
		boolean accountNonLocked = true;
		String role  =(String) request.getSession().getAttribute("role");
		List<Role> listDigerRoller = new ArrayList<Role>();
		
		
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		if(kullanici.getPerson() != null){
			if(role == null){
				for (Role rol : kullanici.getPerson().getRoller() ) {
					authorities.add(new GrantedAuthorityImpl(rol.getName()));
				}
			}else{
				authorities.add(new GrantedAuthorityImpl(role));
				for (Role rol : kullanici.getPerson().getRoller() ) {
					if(!rol.getName().equals(role))
						listDigerRoller.add(rol);
				}
			}
			request.getSession().removeAttribute("role");
		}
		
		dao.saveOrUpdate(kullanici);
		
		MyUser user = new MyUser(kullaniciAdi, parola , enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities, kullanici.getPerson(),listDigerRoller);

		return user;
	}
}