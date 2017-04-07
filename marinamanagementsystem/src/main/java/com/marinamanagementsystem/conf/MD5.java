package com.marinamanagementsystem.conf;

import java.io.PrintStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;




public class MD5
{
  public MD5() {}
  
  public String md5(String userName, String IPAddress, String password)
    throws NoSuchAlgorithmException
  {
    MessageDigest mdAlgorithm = MessageDigest.getInstance("MD5");
    mdAlgorithm.update(password.getBytes());
    
    byte[] digest = mdAlgorithm.digest();
    StringBuffer hexString = new StringBuffer();
    
    for (int i = 0; i < digest.length; i++) {
    	password = Integer.toHexString(0xFF & digest[i]);
      
      if (password.length() < 2) {
    	  password = "0" + password;
      }
      
      hexString.append(password);
    }
    
    Date dNow = new Date();
    SimpleDateFormat currentDateAndTimeFormat = new SimpleDateFormat("dd.MM.YYYY, HH:mm");
    String currentTime = currentDateAndTimeFormat.format(dNow).toString();
    
    String logLine = "Date & time: " + currentTime + "\tIP: " + IPAddress + "\tUsername: " + userName + "\tHash: " + hexString.toString();
    System.out.println(logLine);

    return hexString.toString();
  }
  
  public String md5(String plainText) throws NoSuchAlgorithmException
  {
    MessageDigest mdAlgorithm = MessageDigest.getInstance("MD5");
    mdAlgorithm.update(plainText.getBytes());
    
    byte[] digest = mdAlgorithm.digest();
    StringBuffer hexString = new StringBuffer();
    
    for (int i = 0; i < digest.length; i++) {
      plainText = Integer.toHexString(0xFF & digest[i]);
      
      if (plainText.length() < 2) {
        plainText = "0" + plainText;
      }
      
      hexString.append(plainText);
    }
    
    return hexString.toString();
  }
  
  public static void main(String[] args) {
    try {
      MD5 myMD5 = new MD5();
      myMD5.md5("demo", "myIPAddress", "1234567");
    }
    catch (NoSuchAlgorithmException e) {
      e.printStackTrace();
    }
  }
}