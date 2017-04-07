package com.odtu.mms.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.envers.Audited;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Audited
@Table(name="berth_price")
public class BerthPrice extends BaseModel implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -1775007516197243240L;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="berth_id")
	private Berth berth;
	
	@Column(name = "daily_price")
	private Double dailyPrice;
	
	@Column(name = "weekly_price")
	private Double weeklyPrice;
	
	@Column(name = "monthly_price")
	private Double monthlyPrice;
	
	@Column(name = "six_months_price")
	private Double sixMonthsPrice;
	
	@Column(name = "yearly_price")
	private Double yearlyPrice;

	public Berth getBerth() {
		return berth;
	}

	public void setBerth(Berth berth) {
		this.berth = berth;
	}

	public Double getDailyPrice() {
		return dailyPrice;
	}

	public void setDailyPrice(Double dailyPrice) {
		this.dailyPrice = dailyPrice;
	}

	public Double getWeeklyPrice() {
		return weeklyPrice;
	}

	public void setWeeklyPrice(Double weeklyPrice) {
		this.weeklyPrice = weeklyPrice;
	}

	public Double getMonthlyPrice() {
		return monthlyPrice;
	}

	public void setMonthlyPrice(Double monthlyPrice) {
		this.monthlyPrice = monthlyPrice;
	}

	public Double getSixMonthsPrice() {
		return sixMonthsPrice;
	}

	public void setSixMonthsPrice(Double sixMonthsPrice) {
		this.sixMonthsPrice = sixMonthsPrice;
	}

	public Double getYearlyPrice() {
		return yearlyPrice;
	}

	public void setYearlyPrice(Double yearlyPrice) {
		this.yearlyPrice = yearlyPrice;
	}

}
