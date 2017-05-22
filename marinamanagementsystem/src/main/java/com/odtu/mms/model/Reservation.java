package com.odtu.mms.model;

import java.io.Serializable;
import java.util.Calendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Type;
import org.hibernate.envers.Audited;

@Entity
@Audited
@Table(name="reservation")
public class Reservation extends BaseModel implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4476978481401603882L;
	
	@ManyToOne
	@JoinColumn(name="berth_id")
	private Berth berth;
	
	@ManyToOne
	@JoinColumn(name="yacht_id")
	private Yacht yacht;

	@Column(name = "reservation_start_date")
	private Calendar reservationStartDate;

	@Column(name = "reservation_end_date")
	private Calendar reservationEndDate;
	
	@Column(name = "status",columnDefinition="integer")
	@Type(type = "org.hibernate.type.NumericBooleanType")
	private Boolean status;

	public Berth getBerth() {
		return berth;
	}

	public void setBerth(Berth berth) {
		this.berth = berth;
	}

	public Yacht getYacht() {
		return yacht;
	}

	public void setYacht(Yacht yacht) {
		this.yacht = yacht;
	}

	public Calendar getReservationStartDate() {
		return reservationStartDate;
	}

	public void setReservationStartDate(Calendar reservationStartDate) {
		this.reservationStartDate = reservationStartDate;
	}

	public Calendar getReservationEndDate() {
		return reservationEndDate;
	}

	public void setReservationEndDate(Calendar reservationEndDate) {
		this.reservationEndDate = reservationEndDate;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

}
