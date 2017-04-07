package com.odtu.mms.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.NamedNativeQueries;
import org.hibernate.annotations.NamedNativeQuery;
import org.hibernate.annotations.Type;
import org.hibernate.envers.Audited;


@NamedNativeQueries({
	@NamedNativeQuery(
			name = "listTumRoller",
			query = "select * from role r ",
		        resultClass = Role.class
			)
})

@Entity
@Audited
@Table(name="role")
public class Role extends BaseModel implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3416236747157211459L;

	

//	public static final String ROLE_MARINA_MANAGER = "System Administrator";
	
	public static final String ROLE_SYSTEM_ADMINISTRATOR = "ROLE_SYSTEM_ADMINISTRATOR";
	public static final String ROLE_MARINA_OWNER = "ROLE_MARINA_OWNER";
	public static final String ROLE_YACHT_OWNER = "ROLE_YACHT_OWNER";
	
	public static final Long ROL_MARINA_MANAGER_ID = 1L;
	
	@Column(name = "name", columnDefinition="text")
	@Type(type = "org.hibernate.type.TextType")
	private String name="";

	@Column(name = "display_name", columnDefinition="text")
	@Type(type = "org.hibernate.type.TextType")
	private String displayNmae="";
	
	@Column(name = "status",columnDefinition="integer")
	@Type(type = "org.hibernate.type.NumericBooleanType")
	private Boolean status;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDisplayNmae() {
		return displayNmae;
	}

	public void setDisplayNmae(String displayNmae) {
		this.displayNmae = displayNmae;
	}	

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

}
