package com.marinamanagementsystem.conf;

public class DatabaseSettings
{
  public static final String ClassForName = "com.mysql.jdbc.Driver";
  public static final String dbName = "jdbc:mysql://localhost:3306/etsdb";
  public static final String dbUserName = "etsuser";
  public static final String dbPass = "etspass";
  
  public DatabaseSettings() {}
  
  public String getDBName()
  {
    return "jdbc:mysql://localhost:3306/etsdb";
  }
  
  public String getDBUserName()
  {
    return "etsuser";
  }
  
  public String getDBPass()
  {
    return "etspass";
  }
  
  public String getClassForName()
  {
    return "com.mysql.jdbc.Driver";
  }
}