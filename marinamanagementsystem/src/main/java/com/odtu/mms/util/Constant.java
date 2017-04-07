package com.odtu.mms.util;

public class Constant {
	
	//MAIL
	public final static String MAIL_SUNUCU="smtp-mail.outlook.com";
	public final static String MAIL_KULLANICI="cobanogluibrahim@outlook.com";
	public final static String MAIL_PAROLA="MMS123*a";
	public final static String MAIL_FROM_ADRES="cobanogluibrahim@outlook.com";
	public final static String MAIL_CC_ADRES="";
	public final static String MAIL_BCC_ADRES="";
	public final static String MAIL_PORT="587";
	public final static String MAIL_AUTH="true";
	public final static String MAIL_PROTOCOL="smtp";

	public final static Boolean USE_MAIL=true;
	
	
	//ModelFilter
	public final static String EQUAL=" = ";
	public final static String NOT_EQUAL=" != ";
	public final static String BIGGER_THAN=" > ";
	public final static String LESS_THAN=" < ";
	public final static String LESS_OR_EQUAL=" <= ";
	public final static String BIGGER_OR_EQUAL=" >= ";
	public final static String IN="in";
	public final static String NOT_IN="not in";

	public final static String AND = " and ";
	public final static String OR = " or ";
	public final static String IS_NOT_NULL=" is not null";
	public final static String IS_NULL=" is null";
	public final static String CUSTOM=" custom";
	public final static String JOIN="JOIN";

	
	public final static String LIKE=" like ";
	public final static String RIGHT_LIKE=" like   ";
	public final static String NOT_LIKE=" not like ";
	
	//SAYFALAMA
	public final static Integer SAYFA_LISTLEME_ELEMAN_SAYISI = 10;
	

	public final static Integer LIST_SIZE=10;


//	public final static String SCHEMA_ADI="royalcert";// eğer deneme yapılacaksa 
//	public final static String SCHEMA_ADI="SBUP_DB";
	public final static String UYGULAMA_ADRESI="http://localhost:8080/marinamanagementsystem/";
	public final static String SCHEMA_ADI="dbo";
}
