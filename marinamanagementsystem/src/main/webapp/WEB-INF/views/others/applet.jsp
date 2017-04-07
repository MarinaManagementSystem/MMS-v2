<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
		<!--
		<iframe src="applet2.jsp" allowtransparency="true" frameborder="0" style="position: absolute; top: 1px; left: 10px; width: 60px; height: 120px; z-index: 1;"></iframe>
		 -->
        <div align="center">
        
        <object type="application/x-java-applet"
		    name="MTSMapApplet" width="610" height="260">
		    <param name="wmode" value="opaque">
			<param name="menu" value="false">
		    <param name="codebase" value="http://localhost:8081/MineTrackingSystem/" />
		    <param name="code" value="MapApplet.class" />
		    <param name="archive" value="MapApplet.jar, ojdbc6.jar, mysql-connector-java-5.1.34-bin.jar" />
		    <param name="scriptable" value="true" />
		    <param name="mayscript" value="true" />
		</object>
        
        <!-- 
       	<center>
 	    <script src="js/deployJava.js"></script>
		<script>
    	var attributes = {codebase:'http://localhost:8081/MineTrackingSystem/',
                      code:'MapApplet.class',
                      archive: 'MapApplet.jar, ojdbc6.jar',
                      width: '610', 
                      height: '260'};
	    var parameters = {java_arguments: '-Xmx256m'}; // customize per your needs
	    var version = '1.7' ; // JDK version
	    deployJava.runApplet(attributes, parameters, version);
		</script>
		</center>
		 -->
		 
		</div>

</body>
</html>