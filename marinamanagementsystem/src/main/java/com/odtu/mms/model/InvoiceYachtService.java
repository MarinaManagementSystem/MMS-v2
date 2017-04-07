package com.odtu.mms.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.envers.Audited;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Audited
@Table(name="invoice_yactht_service")
public class InvoiceYachtService extends BaseModel implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 637662226654354748L;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="invoice_id")
	private Invoice invoice;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="yacht_service_id")
	private YachtService yachtService;

	public Invoice getInvoice() {
		return invoice;
	}

	public void setInvoice(Invoice invoice) {
		this.invoice = invoice;
	}

	public YachtService getYachtService() {
		return yachtService;
	}

	public void setYachtService(YachtService yachtService) {
		this.yachtService = yachtService;
	}
	

}
