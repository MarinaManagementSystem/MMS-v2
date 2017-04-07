package com.odtu.mms.mail;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.odtu.mms.util.Constant;

import java.util.Properties;

public class MailSender {
	public static void gonder(String kime, String baslik, String icerik){
		if(Constant.USE_MAIL){
			Properties properties = System.getProperties();
			properties.put("mail.smtp.host", Constant.MAIL_SUNUCU);
			properties.put("mail.smtp.auth", Constant.MAIL_AUTH);
			properties.put("mail.smtp.port", Constant.MAIL_PORT);
			
//			Session ses = Session.getInstance(properties, new RoyalcertMailAuthenticator( Constant.MAIL_KULLANICI, Constant.MAIL_PAROLA));
			Session ses  = Session.getInstance(properties);
			ses.setDebug(true);
			
			try{
				MimeMessage msg = new MimeMessage(ses);
				msg.setFrom(new InternetAddress(Constant.MAIL_FROM_ADRES));
				
				if (kime != null){
					msg.addRecipients(Message.RecipientType.TO, kime);
				}
				
				if (Constant.MAIL_CC_ADRES != null){
					msg.setRecipients(Message.RecipientType.CC,InternetAddress.parse(Constant.MAIL_CC_ADRES, false));
				}
				
				if (Constant.MAIL_BCC_ADRES != null){
					msg.setRecipients(Message.RecipientType.BCC,InternetAddress.parse(Constant.MAIL_BCC_ADRES, false));
				}
				
				msg.setContent(icerik, "text/html;charset=ISO-8859-9");
				msg.setSubject(baslik,"ISO-8859-9");
				msg.saveChanges();
				
				Transport tr = ses.getTransport(Constant.MAIL_PROTOCOL);
				
				tr.connect(Constant.MAIL_SUNUCU,Constant.MAIL_KULLANICI, Constant.MAIL_PAROLA);
				tr.sendMessage(msg, msg.getAllRecipients());
				tr.close();
			}catch(MessagingException e){
				e.printStackTrace();
			}
		}
	}
}
