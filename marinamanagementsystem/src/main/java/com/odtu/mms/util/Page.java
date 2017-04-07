package com.odtu.mms.util;

import java.util.ArrayList;
import java.util.List;

public class Page {

	private List listData = new ArrayList();
	private Integer pageNumber=1;
	private String orderedProperty;
	private Integer dataCount=0;
	private String url="";
	
	public Page(List listData, Integer pageNumber, String orderedProperty, Integer dataCount){
		this.listData=listData;
		this.pageNumber=pageNumber;
		this.orderedProperty=orderedProperty;
		this.dataCount=dataCount;
	}


	public List getListData() {
		return listData;
	}


	public void setListData(List listData) {
		this.listData = listData;
	}


	public Integer getPageNumber() {
		return pageNumber;
	}


	public void setPageNumber(Integer pageNumber) {
		this.pageNumber = pageNumber;
	}


	public String getOrderedProperty() {
		return orderedProperty;
	}


	public void setOrderedProperty(String orderedProperty) {
		this.orderedProperty = orderedProperty;
	}


	public Integer getDataCount() {
		return dataCount;
	}


	public void setDataCount(Integer dataCount) {
		this.dataCount = dataCount;
	}
	
	public Integer getPageCount(){
		if( (this.dataCount%Constant.LIST_SIZE) == 0 )
			return this.dataCount/Constant.LIST_SIZE ;
		else
			return (this.dataCount/Constant.LIST_SIZE)+1 ;
	}


	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}
	
}
