package com.marinamanagementsystem.conf;

import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;


public class SendMailSSL
{
  static String senderAddressOfTheEmail = "info@etrackingsoftware.com";
  static String eMailAddressesOfDevelopers = "ege@etrackingsoftware.com, bariscan@etrackingsoftware.com";
  
  static String hostAddress = "info@etrackingsoftware.com";
  static String hostPassword = "etracking321";
  static String SMTPHost = "smtp.yandex.com.tr";
  static String portForSMTP = "465";
  static String socketFactoryPort = "465";
  
  String fullName = "full name";
  String fromAddress = "from address";
  String subject = "subject";
  String message = "message";
  String phoneNumber = "phone number";
  


  public SendMailSSL() {}
  

  public void sendEmailForContactForm(String fullName, String fromAddress, String subject, String message, String phoneNumber)
  {
    Properties props = new Properties();
    props.put("mail.smtp.host", SMTPHost);
    props.put("mail.smtp.socketFactory.port", socketFactoryPort);
    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.port", portForSMTP);
    
    Session sessionForDevelopers = Session.getDefaultInstance(props);

    try
    {
      Message eMailForDevelopers = new MimeMessage(sessionForDevelopers);
      try {
        eMailForDevelopers.setFrom(new InternetAddress(senderAddressOfTheEmail, "Environment Tracking Software"));
      }
      catch (UnsupportedEncodingException e) {
        e.printStackTrace();
      }
      

      eMailForDevelopers.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(eMailAddressesOfDevelopers));
      eMailForDevelopers.setReplyTo(InternetAddress.parse(fromAddress));
      
      eMailForDevelopers.setSubject("[ETS Notifier] A new contact form is submitted");
      
      Multipart mpForHTML1 = new MimeMultipart();
      MimeBodyPart htmlPart1 = new MimeBodyPart();
      htmlPart1.setContent("<html><body>Dear ETS Engineer,<br><br>A contact form has just been sent, please take care of it. Below, you may find some information about the related contact form:<br><br><fieldset style=\"margin-bottom: 6px; color: #333333; FONT: 11px; PADDING: 3px;\"><legend>Message Details</legend><table style=\"background-color: #ffffff;\" width=\"700px;\" border=\"0\" cellspacing=\"1\" cellpadding=\"1\"><tbody><tr><td style=\"border-color: #FFFFFF; text-align: left;\"><font \"color=\"#000000\" size=\"2px\">Status:</font></td><td style=\"border-color: #FFFFFF; text-align: left;\"><font color=\"#ff8100\" size=\"2px\">Waiting for reply</font></td></tr><tr><td style=\"border-color: #FFFFFF; text-align: left;\"><font color=\"#000000\" size=\"2px\">Sender Name:</font></td><td style=\"border-color: #FFFFFF; text-align: left;\"><font color=\"#333333\" size=\"2px\">" + 
        fullName + " &lsaquo; " + fromAddress + " &rsaquo;</font>" + 
        "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#000000\" size=\"2px\">Phone No:</font>" + 
        "</td>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#333333\" size=\"2px\">" + phoneNumber + "</font>" + 
        "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#000000\" size=\"2px\">Subject:</font>" + 
        "</td>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#333333\" size=\"2px\">" + subject + "</font>" + 
        "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#000000\" size=\"2px\">Message:</font>" + 
        "</td>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#333333\" size=\"2px\">" + message + "</font>" + 
        "</td>" + 
        "</tr>" + 
        "</tbody>" + 
        "</table>" + 
        "</fieldset>" + 
        "<br>" + 
        "Please do not reply to this e-mail." + 
        "<br><br>" + 
        "Best wishes," + 
        "<br><br>--<br>" + 
        "<img src=\"http://gamerznetwork.net/images/etrackingsoftware/etrackingsoftware-signature.png\" alt=\"ETS Signature\" />" + 
        "</body></html>", 
        "text/html; charset=ISO-8859-9");
      mpForHTML1.addBodyPart(htmlPart1);
      eMailForDevelopers.setContent(mpForHTML1);
      
      Transport.send(eMailForDevelopers);
      
      System.out.println("E-mail for developers about the contact form is successfully sent.");
    }
    catch (MessagingException e) {
      throw new RuntimeException(e);
    }
    
    Session sessionForCustomers = Session.getDefaultInstance(props);

    try
    {
      Message eMailForCustomer = new MimeMessage(sessionForCustomers);
      try {
        eMailForCustomer.setFrom(new InternetAddress(senderAddressOfTheEmail, "Environment Tracking Software"));
      }
      catch (UnsupportedEncodingException e) {
        e.printStackTrace();
      }
      
      eMailForCustomer.setRecipients(Message.RecipientType.TO, InternetAddress.parse(fromAddress));
      eMailForCustomer.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(senderAddressOfTheEmail));
      eMailForCustomer.setReplyTo(InternetAddress.parse(senderAddressOfTheEmail));
      
      eMailForCustomer.setSubject("[ETS Notifier] We received your message");
      
      Multipart mpForHTML2 = new MimeMultipart();
      MimeBodyPart htmlPart2 = new MimeBodyPart();
      htmlPart2.setContent("<html><body>Dear " + 
      
        fullName + ",<br><br>" + 
        "We received your message and we will get back to you as soon as possible. Below, you may find some information about the contact form you have sent:<br><br>" + 
        "<fieldset style=\"margin-bottom: 6px; color: #333333; FONT: 11px; PADDING: 3px;\">" + 
        "<legend>Contact Form Details</legend>" + 
        "<table style=\"background-color: #ffffff;\" width=\"700px;\" border=\"0\" cellspacing=\"1\" cellpadding=\"1\">" + 
        "<tbody>" + 
        "<tr>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font \"color=\"#000000\" size=\"2px\">Status:</font>" + 
        "</td>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#ff8100\" size=\"2px\">Waiting for reply</font>" + 
        "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#000000\" size=\"2px\">Name:</font>" + 
        "</td>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#333333\" size=\"2px\">" + fullName + " &lsaquo; " + fromAddress + " &rsaquo;</font>" + 
        "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#000000\" size=\"2px\">Phone No:</font>" + 
        "</td>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#333333\" size=\"2px\">" + phoneNumber + "</font>" + 
        "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#000000\" size=\"2px\">Subject:</font>" + 
        "</td>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#333333\" size=\"2px\">" + subject + "</font>" + 
        "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#000000\" size=\"2px\">Message:</font>" + 
        "</td>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#333333\" size=\"2px\">" + message + "</font>" + 
        "</td>" + 
        "</tr>" + 
        "</tbody>" + 
        "</table>" + 
        "</fieldset>" + 
        "<br>" + 
        "Please do not reply to this e-mail." + 
        "<br><br>" + 
        "Best wishes," + 
        "<br><br>--<br>" + 
        "<img src=\"http://gamerznetwork.net/images/etrackingsoftware/etrackingsoftware-signature.png\" alt=\"ETS Signature\" />" + 
        "</body></html>", 
        "text/html; charset=ISO-8859-9");
      mpForHTML2.addBodyPart(htmlPart2);
      eMailForCustomer.setContent(mpForHTML2);
      
      Transport.send(eMailForCustomer);
      
      System.out.println("E-mail for the customer about the contact form is successfully sent.");
    }
    catch (MessagingException e) {
      throw new RuntimeException(e);
    }
  }
  
  public void sendEmailToETSDevelopersAboutLWR(String personnelInfo, String warningMessage, String moteID, String moteLocation)
  {
    System.out.println("FIELD ENGINEER E-MAIL (DE): " + personnelInfo);
    Properties props = new Properties();
    props.put("mail.smtp.host", SMTPHost);
    props.put("mail.smtp.socketFactory.port", socketFactoryPort);
    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.port", portForSMTP);
    
    Session sessionForDevelopers = Session.getDefaultInstance(props);

    try
    {
      Message eMailForDevelopers = new MimeMessage(sessionForDevelopers);
      try {
        eMailForDevelopers.setFrom(new InternetAddress(senderAddressOfTheEmail, "Environment Tracking Software"));
      }
      catch (UnsupportedEncodingException e) {
        e.printStackTrace();
      }
      

      eMailForDevelopers.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(eMailAddressesOfDevelopers));
      eMailForDevelopers.setReplyTo(InternetAddress.parse(senderAddressOfTheEmail));
      
      eMailForDevelopers.setSubject("[ETS Notifier] A new warning report is dispatched");
      
      Multipart mpForHTML1 = new MimeMultipart();
      MimeBodyPart htmlPart1 = new MimeBodyPart();
      htmlPart1.setContent("<html><body>Dear ETS Developer,<br><br>Please notice that a new warning report for mote <b>" + 
      

        moteID + "</b> has just been dispatched and sent to the related personnel. Below, you may find some information about the related warning report:<br><br>" + 
        "<fieldset style=\"margin-bottom: 6px; color: #333333; FONT: 11px; PADDING: 3px;\">" + 
        "<legend>Warning Report Details</legend>" + 
        "<table style=\"background-color: #ffffff;\" width=\"700px;\" border=\"0\" cellspacing=\"1\" cellpadding=\"1\">" + 
        "<tbody>" + 
        "<tr>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font \"color=\"#000000\" size=\"2px\">Related mote ID:</font>" + 
        "</td>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#333333\" size=\"2px\">" + moteID + "</font>" + 
        "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font \"color=\"#000000\" size=\"2px\">Mote Location:</font>" + 
        "</td>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#333333\" size=\"2px\">" + moteLocation + "</font>" + 
        "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#000000\" size=\"2px\">Related personnel <br>of mote " + moteID + ":</font>" + 
        "</td>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#333333\" size=\"2px\">" + personnelInfo + "</font>" + 
        "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#000000\" size=\"2px\">Warning message(s):</font>" + 
        "</td>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#333333\" size=\"2px\">" + warningMessage + "</font>" + 
        "</td>" + 
        "</tr>" + 
        "</tbody>" + 
        "</table>" + 
        "</fieldset>" + 
        "<br>" + 
        "Please do not reply to this e-mail." + 
        "<br><br>" + 
        "Best wishes," + 
        "<br><br>--<br>" + 
        "<img src=\"http://gamerznetwork.net/images/etrackingsoftware/etrackingsoftware-signature.png\" alt=\"ETS Signature\" />" + 
        "</body></html>", 
        "text/html; charset=ISO-8859-9");
      mpForHTML1.addBodyPart(htmlPart1);
      eMailForDevelopers.setContent(mpForHTML1);
      
      Transport.send(eMailForDevelopers);
      
      System.out.println("E-mail for developers about the LWR is successfully sent.");
    }
    catch (MessagingException e) {
      throw new RuntimeException(e);
    }
  }
  

  public void sendEmailToFieldEngineersAboutLWR(String fullNameOfFieldEngineer, String fieldEngineerAddress, String warningMessage, String moteID, String moteLocation)
  {
    System.out.println("FIELD ENGINEER E-MAIL (FE): " + fullNameOfFieldEngineer);
    Properties props = new Properties();
    props.put("mail.smtp.host", SMTPHost);
    props.put("mail.smtp.socketFactory.port", socketFactoryPort);
    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.port", portForSMTP);
    
    Session sessionForFieldEngineer = Session.getDefaultInstance(props);

    try
    {
      Message eMailForFieldEngineer = new MimeMessage(sessionForFieldEngineer);
      try {
        eMailForFieldEngineer.setFrom(new InternetAddress(senderAddressOfTheEmail, "Environment Tracking Software"));
      }
      catch (UnsupportedEncodingException e) {
        e.printStackTrace();
      }
      
      eMailForFieldEngineer.setRecipients(Message.RecipientType.TO, InternetAddress.parse(fieldEngineerAddress));
      
      eMailForFieldEngineer.setReplyTo(InternetAddress.parse(senderAddressOfTheEmail));
      
      eMailForFieldEngineer.setSubject("[ETS Notifier] A new warning report is dispatched");
      
      Multipart mpForHTML2 = new MimeMultipart();
      MimeBodyPart htmlPart2 = new MimeBodyPart();
      htmlPart2.setContent("<html><body>Dear " + 
      
        fullNameOfFieldEngineer + ",<br><br>" + 
        "Please notice that a new warning report for mote <b>" + moteID + "</b> has just been dispatched. Below, you may find some information about the warning report:<br><br>" + 
        "<fieldset style=\"margin-bottom: 6px; color: #333333; FONT: 11px; PADDING: 3px;\">" + 
        "<legend>Contact Form Details</legend>" + 
        "<table style=\"background-color: #ffffff;\" width=\"700px;\" border=\"0\" cellspacing=\"1\" cellpadding=\"1\">" + 
        "<tbody>" + 
        "<tr>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font \"color=\"#000000\" size=\"2px\">Related mote ID:</font>" + 
        "</td>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#333333\" size=\"2px\">" + moteID + "</font>" + 
        "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font \"color=\"#000000\" size=\"2px\">Mote Location:</font>" + 
        "</td>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#333333\" size=\"2px\">" + moteLocation + "</font>" + 
        "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#000000\" size=\"2px\">Personnel of mote " + moteID + ":</font>" + 
        "</td>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#333333\" size=\"2px\">" + fullNameOfFieldEngineer + " &lsaquo; " + fieldEngineerAddress + " &rsaquo; </font>" + 
        "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#000000\" size=\"2px\">Warning message(s):</font>" + 
        "</td>" + 
        "<td style=\"border-color: #FFFFFF; text-align: left;\">" + 
        "<font color=\"#333333\" size=\"2px\">" + warningMessage + "</font>" + 
        "</td>" + 
        "</tr>" + 
        "</tbody>" + 
        "</table>" + 
        "</fieldset>" + 
        "<br>" + 
        "Please do not reply to this e-mail." + 
        "<br><br>" + 
        "Best wishes," + 
        "<br><br>--<br>" + 
        "<img src=\"http://gamerznetwork.net/images/etrackingsoftware/etrackingsoftware-signature.png\" alt=\"ETS Signature\" />" + 
        "</body></html>", 
        "text/html; charset=ISO-8859-9");
      mpForHTML2.addBodyPart(htmlPart2);
      eMailForFieldEngineer.setContent(mpForHTML2);
      
      Transport.send(eMailForFieldEngineer);
      
      System.out.println("E-mail for the field engineer about the LWR is successfully sent.");
    }
    catch (MessagingException e) {
      throw new RuntimeException(e);
    }
  }
  
  public static void main(String[] args) {}
}
