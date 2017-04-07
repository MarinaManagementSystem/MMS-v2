<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="com.microsoft.sqlserver.jdbc.SQLServerDriver" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MMS DB Connection</title>
</head>
<body>



<h2>Azure DB Connection</h2>
<ul>
<%

	String connectionString =  
	"jdbc:sqlserver://marinams.database.windows.net:1433;"  
	+ "database=mms_db;"  
	+ "user=marinams_admin@marinams;"  
	+ "password=MMS123*a;"  
	+ "encrypt=true;"  
	+ "trustServerCertificate=false;"  
	+ "hostNameInCertificate=*.database.windows.net;"
	+ "characterEncoding=utf-8;"
	+ "loginTimeout=30;";
	
	// Declare the JDBC objects.
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); 
	Connection connection = null;
    Statement stmt = null;
    ResultSet rs = null;
	connection = DriverManager.getConnection(connectionString); 

    // Create and execute an SQL statement that returns a  
    // set of data and then display it.  
    String SQL = "SELECT * FROM dbo.kullanici;";
    stmt = connection.createStatement();  
    rs = stmt.executeQuery(SQL);  

    while (rs.next()) {  
        out.print(rs.getString("id") + ". " + rs.getString("kullanici_name") + " " + rs.getString("password") + "<br/>");  
     }  

%>




</ul>

</body>
</html>
