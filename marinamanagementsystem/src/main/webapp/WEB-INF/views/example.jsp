<%@ page language="java" contentType="text/html; charset=ISO-8859-9" import="java.io.*, java.util.*, java.util.Date, java.sql.*, javax.servlet.*, java.text.* "
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="en"> <!--<![endif]-->

<head>
	<jsp:include page="header.jsp" />
	<title>Example Page - Environment Tracking Software</title>
</head>

<jsp:include page="menu.jsp" />

<!-- header -->
<header class="height">


    <div data-image-mobile="assets/images/bg-plannet-parallax.jpg" data-image="assets/images/bg-plannet-parallax.jpg" data-type="parallax" data-height="400" data-stellar-background-ratio="0" class="media-section">

        <div class="display-table">
            <div class="inner">

                <div class="flexslider std-slider center-controls" data-height="" data-loop="true" data-smooth="false" data-slideshow="true" data-speed="15000" data-animspeed="550" data-controls="false" data-dircontrols="true">
                    <ul class="slides">
                        <li>
                            <div class="container">
                                <div class="text-left width inner">
                                    <h2 class="page-title animated" data-fx="fadeInDown">ABOUT US</h2>

                                    <h3 class="animated" data-fx="bounceIn">
                                        Want to learn more about the ETS and the team behind this plot?<br/>
                                        Cool, scroll down a bit and find out!
                                    </h3>
                                </div>
                            </div>
                        </li>



                    </ul>
                </div>

            </div>
        </div>
    </div>
</header>
<!-- / header -->

<!--  section icon box -->
<div class="grey content-area" id="iconbuttons" style="background-color: white;">

    <div class="container">

		<div class="row">
		
		<%
		if(session.getAttribute("isMobile").toString().equalsIgnoreCase("false"))
		{
			%>
		
			<div class="row section-header">
			
	            <div class="col-sm-12 col-md-12">
	
	                <h2>What is ETS?</h2>
	
	                <p align="justify" class="summary">Environment Tracking Software, ETS, is a software that uses Wireless Sensor Networks (WSN) communications infrastructure to achieve its goal. The primary goal is to track the environment by checking the temperature, humidity and light in a specific area on a pre-defined time interval to decide whether the environment is in living conditions or not.</p>
	
	            </div>
	            <div class="col-sm-12 col-md-12">
	
	                <h2>How does it work?</h2>
	
	                <p align="justify" class="summary">
	                    The wireless sensors are programmed to retrieve some information from the environment they are located in. <a href="http://www.advanticsys.com/shop/asxm1000-p-24.html" target="_blank">Advantic System's AS-XM1000 802.15.4</a> motes are used to achieve this. The motes are programmed in a way that they sense the temperature, humidity and light with given specifications.
	                </p>
	                <p align="justify" class="summary">
	                    They are communicating in a multi-hopping manner where the base station (sensor) gathers all the information and sends it to a database. This information is then processed to determine whether a warning should be dispatched to field engineers or not. All these warnings and the data retrieved from the motes up until that time are available on this very web application.
	                </p>
	
	            </div>
	            <div class="col-sm-12 col-md-12">
	
					<a name="ETSTeamForWebApp" id="ETSTeamForWebApp" style="display: block; position: relative; top: -110px; visibility: hidden;">
					</a>
					<h2>About the ETS Team</h2>
	
					<p align="justify" class="summary">We are senior students in the Department of Computer Engineering at Middle East Technical University, Northern Cyprus Campus and we all take the advantage of a cup of coffee to boost our way of figuring ETS-related problems out, indeed. </p>
	            </div>
	        </div>
	        
	        <div class="row">
	
	
	            <div class="col-sm-6 col-md-6 animated" data-fx="fadeInUp">
	                <div class="personBox text-center">
	
	
	                    <div class="person-thumbnail">
	                        <a href="http://metu.edu.tr/~e186267" target="_blank"><img src="assets/images/content/EgeGorgun.jpg" alt="" title=""></a>
	                    </div>
	
	                    <a href="http://metu.edu.tr/~e186267" target="_blank"><h4>Ege GÖRGÜN
	                        <span>a.k.a smartass</span>
	                    </h4></a>
	
	                    <p>Web Developer</br>Mote Programmer</p>
	
	                    <ul class="socialNormal list-inline">
	                        <li><a data-original-title="Facebook" href="https://www.facebook.com/ege.gorgun" data-toggle="tooltip" title="" target="_blank"><i
	                                class="fa fa-fw fa-facebook"></i></a></li>
	                        <li><a data-original-title="LinkedIn" href="http://www.linkedin.com/in/egegorgun/en" data-toggle="tooltip" title="" target="_blank"><i
	                                class="fa fa-fw fa-linkedin-square"></i></a></li>
	                        <li><a data-original-title="Google+" href="https://plus.google.com/+EgeGorgun/" data-toggle="tooltip" title="" target="_blank"><i
	                                class="fa fa-fw fa-google-plus"></i></a></li>
	                        <li><a data-original-title="Skype" href="skype:ege.gorgun?call" data-toggle="tooltip" title="" target="_blank"><i
	                                class="fa fa-fw fa-skype"></i></a></li>
	                    </ul>
	
	
	                </div>
	            </div>
	            <div class="col-sm-6 col-md-6 animated" data-fx="fadeInDown">
	                <div class="personBox text-center">
	
	                    <div class="person-thumbnail">
	                        <a href="bariscan.jsp"><img src="assets/images/content/BariscanSalman.jpg" alt="" title=""></a>
	                    </div>
	
	                    <a href="bariscan.jsp"><h4>Barýþcan SALMAN
	                        <span>a.k.a asjdlkamsd</span>
	                    </h4></a>
	
	                    <p>Web Developer</br>Mote Programmer</p>
	
	                    <ul class="socialNormal list-inline">
	                        <li><a data-original-title="Facebook" href="https://www.facebook.com/baosalman" data-toggle="tooltip" title="" target="_blank"><i
	                                class="fa fa-fw fa-facebook"></i></a></li>
	                        <li><a data-original-title="Twitter" href="#" data-toggle="tooltip" title=""><i
	                                class="fa fa-fw fa-twitter"></i></a></li>
	                        <li><a data-original-title="Google+" href="https://plus.google.com/u/0/110531876645770327884/posts" data-toggle="tooltip" title="" target="_blank"><i
								                                class="fa fa-fw fa-google-plus"></i></a></li>
	                        <li><a data-original-title="Dribble" href="#" data-toggle="tooltip" title=""><i
	                                class="fa fa-fw fa-dribbble"></i></a></li>
	                    </ul>
	
	
	                </div>
	            </div>
	        </div>
	    	<%
		}
		else
		{
			%>
	        <div class="row">
	                <div class="col-md-12 animated" data-fx="fadeInLeft">
	
	                    <div class="panel-group accordion" id="accordion">
	                        <div class="panel">
	                            <div class="panel-heading">
	                                <a href="#collapse1" data-parent="#accordion" data-toggle="collapse">
	                                    What is ETS?
	                                </a>
	                            </div>
	                            <div class="panel-collapse collapse in" id="collapse1">
	                                <div class="panel-body">
	                                    <h2>What is ETS?</h2>
	                                    <p align="justify" class="summary">Environment Tracking Software, ETS, is a software that uses Wireless Sensor Networks (WSN) communications infrastructure to achieve its goal. The primary goal is to track the environment by checking the temperature, humidity and light in a specific area on a pre-defined time interval to decide whether the environment is in living conditions or not.</p>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="panel">
	                            <div class="panel-heading">
	                                <a class="collapsed" href="#collapse2" data-parent="#accordion" data-toggle="collapse">
	                                    How does it work?
	                                </a>
	                            </div>
	                            <div class="panel-collapse collapse" id="collapse2">
	                                <div class="panel-body">
	                                    <h2>How does it work?</h2>
						                <p align="justify" class="summary">
						                    The wireless sensors are programmed to retrieve some information from the environment they are located in. <a href="http://www.advanticsys.com/shop/asxm1000-p-24.html" target="_blank">Advantic System's AS-XM1000 802.15.4</a> motes are used to achieve this. The motes are programmed in a way that they sense the temperature, humidity and light with given specifications.
						                </p>
						                <p align="justify" class="summary">
						                    They are communicating in a multi-hopping manner where the base station (sensor) gathers all the information and sends it to a database. This information is then processed to determine whether a warning should be dispatched to field engineers or not. All these warnings and the data retrieved from the motes up until that time are available on this very web application.
						                </p>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="panel">
	                            <div class="panel-heading">
	                                <a class="collapsed" href="#collapse3" data-parent="#accordion" data-toggle="collapse">
	                                    About the ETS Team
	                                </a>
	                            </div>
	                            <div class="panel-collapse collapse" id="collapse3">
	                                <div class="panel-body">
						                <h2>About the ETS Team</h2>
						
										<p align="justify" class="summary">We are senior students in the Department of Computer Engineering at Middle East Technical University, Northern Cyprus Campus and we all take the advantage of a cup of coffee to boost our way of figuring ETS-related problems out, indeed. </p>
										
										<div class="row">
								            <div class="col-sm-6 col-md-6 animated" data-fx="fadeInUp">
								                <div class="personBox text-center">
								
								
								                    <div class="person-thumbnail">
								                        <a href="http://metu.edu.tr/~e186267" target="_blank"><img src="assets/images/content/EgeGorgun.jpg" alt="" title=""></a>
								                    </div>
								
								                    <a href="http://metu.edu.tr/~e186267" target="_blank"><h4>Ege GÖRGÜN
								                        <span>a.k.a smartass</span>
								                    </h4></a>
								
								                    <p>Web Developer</br>Mote Programmer</p>
								
								                    <ul class="socialNormal list-inline">
								                        <li><a data-original-title="Facebook" href="https://www.facebook.com/ege.gorgun" data-toggle="tooltip" title="" target="_blank"><i
								                                class="fa fa-fw fa-facebook"></i></a></li>
								                        <li><a data-original-title="LinkedIn" href="http://www.linkedin.com/in/egegorgun/en" data-toggle="tooltip" title="" target="_blank"><i
								                                class="fa fa-fw fa-linkedin-square"></i></a></li>
								                        <li><a data-original-title="Google+" href="https://plus.google.com/+EgeGorgun/" data-toggle="tooltip" title="" target="_blank"><i
								                                class="fa fa-fw fa-google-plus"></i></a></li>
								                        <li><a data-original-title="Skype" href="skype:ege.gorgun?call" data-toggle="tooltip" title="" target="_blank"><i
								                                class="fa fa-fw fa-skype"></i></a></li>
								                    </ul>
								
								
								                </div>
								            </div>
								            <div class="col-sm-6 col-md-6 animated" data-fx="fadeInDown">
								                <div class="personBox text-center">
								
								                    <div class="person-thumbnail">
								                        <a href="bariscan.jsp"><img src="assets/images/content/BariscanSalman.jpg" alt="" title=""></a>
								                    </div>
								
								                    <a href="bariscan.jsp"><h4>Barýþcan SALMAN
								                        <span>a.k.a asjdlkamsd</span>
								                    </h4></a>
								
								                    <p>Web Developer</br>Mote Programmer</p>
								
								                    <ul class="socialNormal list-inline">
								                        <li><a data-original-title="Facebook" href="https://www.facebook.com/baosalman" data-toggle="tooltip" title="" target="_blank"><i
								                                class="fa fa-fw fa-facebook"></i></a></li>
								                        <li><a data-original-title="Twitter" href="#" data-toggle="tooltip" title=""><i
								                                class="fa fa-fw fa-twitter"></i></a></li>
								                        <li><a data-original-title="Google+" href="https://plus.google.com/u/0/110531876645770327884/posts" data-toggle="tooltip" title="" target="_blank"><i
								                                class="fa fa-fw fa-google-plus"></i></a></li>
								                        <li><a data-original-title="Dribble" href="#" data-toggle="tooltip" title=""><i
								                                class="fa fa-fw fa-dribbble"></i></a></li>
								                    </ul>
								
								
								                </div>
								            </div>
	        							</div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	        </div>
			<%
		}
	    %>
	        
		</div>
    </div>
</div>
<!-- / section -->

<br>
<!-- footer -->

<jsp:include page="footer.jsp" />
