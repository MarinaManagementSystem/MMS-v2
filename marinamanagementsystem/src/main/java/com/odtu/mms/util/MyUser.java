package com.odtu.mms.util;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.odtu.mms.model.Person;
import com.odtu.mms.model.Role;


public class MyUser extends User {
	private static final long serialVersionUID = 1L;

	private Person kisi;

	private Calendar sonHareketZamani;
	
	private String sessionId="";
	
	private boolean forceLogout=false;
	
	private boolean premium=false;
	
	private boolean kisitliUye=false;
	
	private Integer loginCount;
	
	List<? extends GrantedAuthority> digerGrantedAuthorities;
	List<Role> listDigerRoller = new ArrayList<Role>();
	
	
//	private GrantedAuthority gecerliGrantedAuthority;
	
	public MyUser(String username, String password, boolean enabled,
			boolean accountNonExpired, boolean credentialsNonExpired,
			boolean accountNonLocked,
			List<? extends GrantedAuthority> authorities) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired,
				accountNonLocked, authorities);
	}

	public MyUser(String username, String password, boolean enabled,
			boolean accountNonExpired, boolean credentialsNonExpired,
			boolean accountNonLocked,
			List<? extends GrantedAuthority> authorities, Person kisi,List<Role> listDigerRoller) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired,accountNonLocked, authorities);
		this.kisi = kisi;
//		this.premium=kisi.isPremium();
//		this.kisitliUye=kisi.isKisitliUye();
		this.loginCount=loginCount;
		this.digerGrantedAuthorities = authorities;
		this.listDigerRoller=listDigerRoller;
	}
	
//	public GrantedAuthority getGecerliRol(GrantedAuthority grantedAuthority){
//		return this.gecerliGrantedAuthority = grantedAuthority;
//	}

	public Person getPerson() {
		return kisi;
	}

	public void setPerson(Person kisi) {
		this.kisi = kisi;
	}

	public boolean isPremium() {
		return premium;
	}

	public void setPremium(boolean premium) {
		this.premium = premium;
	}

	public boolean isKisitliUye() {
		return kisitliUye;
	}

	public void setKisitliUye(boolean kisitliUye) {
		this.kisitliUye = kisitliUye;
	}

	public Integer getLoginCount() {
		return loginCount;
	}

//	public GrantedAuthority getGecerliGrantedAuthority() {
//		return gecerliGrantedAuthority;
//	}

	public Collection<GrantedAuthority> getAuthorities(String grantedAuthority) {
	    List<GrantedAuthority> permissions = new ArrayList<GrantedAuthority>();
	    for (GrantedAuthority role: digerGrantedAuthorities) {
	    	if(grantedAuthority.equals(role.getAuthority())){
	    		permissions.add(role);
	    		return permissions;
	    	}
	    }
	    return permissions;
	}

	public List<Role> getListDigerRoller() {
		return listDigerRoller;
	}

	public void setListDigerRoller(List<Role> listRoleerRoller) {
		this.listDigerRoller = listDigerRoller;
	}
	

}
