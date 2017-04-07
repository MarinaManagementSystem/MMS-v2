package com.odtu.mms.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.NamedNativeQueries;
import org.hibernate.annotations.NamedNativeQuery;

@NamedNativeQueries({
	
	@NamedNativeQuery(
			name = "listSBFStokKalanLog",
			query = "select * from T_SBF_STOK_KALAN_LOG " ,
		        resultClass = SBFStokKalanLog.class
			)
})

//@Entity
//@Table(name="T_SBF_STOK_KALAN_LOG")
public class SBFStokKalanLog extends BaseModel implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -5732699909362659364L;

	@Column(name="GTIP_NO")
	private String gTipNo;

	public String getgTipNo() {
		return gTipNo;
	}

	public void setgTipNo(String gTipNo) {
		this.gTipNo = gTipNo;
	}


}
