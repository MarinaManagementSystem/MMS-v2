package com.odtu.mms.util;

import java.util.List;

public class Sayfalama {

	
	private Integer baslangic;
	private Integer bitis;
	private String siralama;
	private Integer sayi;
	private String adres;
	private Integer sayfaNo;
	private List listVeri;
	private String parametre;
	private Integer kayitSayisi;
	
	public Sayfalama(Integer sayfaNo, String siralama, String adres){
		if(sayfaNo == null)
			sayfaNo=1;
		this.sayfaNo=sayfaNo;
		this.siralama=siralama;
		this.adres=adres;
		
		this.baslangic=sayfaNo;
		this.bitis=(sayfaNo+1)*Constant.SAYFA_LISTLEME_ELEMAN_SAYISI;
		
	}
	
	public Sayfalama(Integer sayfaNo, String siralama, String adres,Integer kayitSayisi){
		if(sayfaNo == null)
			sayfaNo=1;
		this.sayfaNo=sayfaNo;
		this.siralama=siralama;
		this.adres=adres;
		
		this.baslangic=sayfaNo;
		if(kayitSayisi == null)
			this.kayitSayisi = Constant.SAYFA_LISTLEME_ELEMAN_SAYISI;
		else
			this.kayitSayisi=kayitSayisi;
		this.bitis=(sayfaNo+1)*this.kayitSayisi;
		
	}
	
	public Integer getBaslangic() {
		return baslangic;
	}
	public void setBaslangic(Integer baslangic) {
		this.baslangic = baslangic;
	}
	public Integer getBitis() {
		return bitis;
	}
	public void setBitis(Integer bitis) {
		this.bitis = bitis;
	}
	public String getSiralama() {
		return siralama;
	}
	public void setSiralama(String siralama) {
		this.siralama = siralama;
	}
	public Integer getSayi() {
		return sayi;
	}
	public void setSayi(Integer sayi) {
		this.sayi = sayi;
	}
	public String getAdres() {
		return adres;
	}
	public void setAdres(String adres) {
		this.adres = adres;
	}	
	public Integer getSayfaNo() {
		return sayfaNo;
	}

	public void setSayfaNo(Integer sayfaNo) {
		this.sayfaNo = sayfaNo;
	}

	public List getListVeri() {
		return listVeri;
	}

	public void setListVeri(List listVeri) {
		this.listVeri = listVeri;
	}

	public String getParametre() {
		return parametre;
	}

	public void setParametre(String parametre) {
		this.parametre = parametre;
	}

	public Integer getSayfaAdedi(){
		if(this.kayitSayisi == null)
			this.kayitSayisi = Constant.SAYFA_LISTLEME_ELEMAN_SAYISI;
		
		
		if(sayi%this.kayitSayisi == 0)
			return (sayi / this.kayitSayisi);
		return (sayi / this.kayitSayisi) + 1 ;
	}

	public Integer getKayitSayisi() {
		return kayitSayisi;
	}

	public void setKayitSayisi(Integer kayitSayisi) {
		this.kayitSayisi = kayitSayisi;
	}
	
}
