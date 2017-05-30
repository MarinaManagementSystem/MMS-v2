<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../includes/springTagLibraries.jsp"%>

<html>

<head>

    <title>About Us - <fmt:message key="label.application.title"/></title>
    
	<%@include file="../includes/commonMeta.jsp"%>
	<%@include file="../includes/commonStyles.jsp"%>
	<%@include file="../includes/commonScripts.jsp"%>

</head>

<%@include file="../includes/openingDivTagsForMobileViews.jsp"%>


<!-- header -->
<header class="height">


    <div data-image-mobile="../resources/assets/images/bg-plannet-parallax.jpg" data-image="../resources/assets/images/bg-plannet-parallax.jpg" data-type="parallax" data-height="400" data-stellar-background-ratio="0" class="media-section">

        <div class="display-table">
            <div class="inner">

                <div class="flexslider std-slider center-controls" data-height="" data-loop="true" data-smooth="false" data-slideshow="true" data-speed="15000" data-animspeed="550" data-controls="false" data-dircontrols="true">
                    <ul class="slides">
                        <li>
                            <div class="container">
                                <div class="text-left width inner">
                                    <h2 class="page-title animated" data-fx="fadeInDown">ABOUT US</h2>

                                    <h3 class="animated" data-fx="bounceIn">
                                        Want to learn more about the MMS and the team behind this plot?<br/>
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

<body class="withAnimation">

	<%@include file="../includes/header.jsp"%>

	<!--  section icon box -->
	<div class="grey content-area" id="iconbuttons" style="background-color: white;">

	    <div class="container">
	
			<div class="row" style="padding-bottom: 80px;">
	
			
				<div class="row section-header">
				
		            <div class="col-sm-12 col-md-12">
		
		                <h2>Project Overview / What is MMS?</h2>
		
		                <p align="justify" class="summary">Since the construction industry is growing day by day in Turkey, lots of art of the technology marina projects are also being realized. This not only attracts the attention of the construction and engineering companies but also the yachting industry. More and more yachts are being bought each and every day, as a result.</p>
		                <p align="justify" class="summary">Here, Marina Management System (MMS) welcomes the problem. It allows the yacht owners to get up-to-date information about a marina such as available and yacht-specific suitable berths (wet & dry), and fees that are going to be charged upon a procurement of a service provided by that marina company. Yacht owners may use the MMS to go back and see their procurement history as well.</p>
		                <p align="justify" class="summary">The MMS also allows the marina owners to operate their business more efficiently and effectively by providing up-to-date information about their marina such as available berths (wet & dry), consumptions per yacht in terms of electricity & water, special services procured per yacht (cleaning, food & beverages, maintenance etc.) and consumptions made by per customer on public areas (marina restaurants, sports centers, beaches etc.).</p>
		
		            </div>
		            <div class="col-sm-12 col-md-12">
		
		                <h2>Purpose</h2>
		
		                <p align="justify" class="summary">
		                    One of the objectives of this project is to provide a web application to marina owners which will allow them to manage a single marina or multiple marinas, geographically distributed or not, more efficiently and effectively.
		                </p>
		                <p align="justify" class="summary">
		                    Another objective is to provide yacht owners with a web interface, which will allow them to browse a marina’s available and yacht-specific suitable berths (wet & dry), fees that are going to be charged upon a procurement of a service and a procurement history, if there is any.
		                </p>
		
		            </div>
		            <div class="col-sm-12 col-md-12">
		
						<a name="MMSTeamForWebApp" id="MMSTeamForWebApp" style="display: block; position: relative; top: -110px; visibility: hidden;">
						</a>
						<h2>About the MMS Team</h2>
		
						<p align="justify" class="summary">We are graduate students in the Department of Computer Engineering at Middle East Technical University, Ankara Campus and we all take the advantage of a cup of coffee to boost our way of figuring MMS-related problems out, indeed. </p>
		            </div>
		        </div>
		        
		        <div class="row">
		
		            <div class="col-sm-6 col-md-3 animated activate fadeInUp" data-fx="fadeInUp">
		                <div class="personBox text-center">
		
		
		                    <div class="person-thumbnail">
		                        <a href="#" target="_blank"><img src="../resources/assets/images/content/AtaTanerAydemir.jpg" alt="" title=""></a>
		                    </div>
		
		                    <a href="#" target="_blank"><h4>Ata Taner AYDEMİR
		                        <span>a.k.a lale</span>
		                    </h4></a>
		
		                    <p>Back End Developer</p>
		
		                    <ul class="socialNormal list-inline">
		                        <li><a data-original-title="Facebook" href="#" data-toggle="tooltip" title="" target="_blank"><i
		                                class="fa fa-fw fa-facebook"></i></a></li>
		                        <li><a data-original-title="LinkedIn" href="#" data-toggle="tooltip" title="" target="_blank"><i
		                                class="fa fa-fw fa-linkedin-square"></i></a></li>
		                        <li><a data-original-title="Google+" href="#" data-toggle="tooltip" title="" target="_blank"><i
		                                class="fa fa-fw fa-google-plus"></i></a></li>
		                        <li><a data-original-title="Skype" href="#" data-toggle="tooltip" title="" target="_blank"><i
		                                class="fa fa-fw fa-skype"></i></a></li>
		                    </ul>
		
		
		                </div>
		            </div>
		            <div class="col-sm-6 col-md-3 animated activate fadeInDown" data-fx="fadeInDown">
		                <div class="personBox text-center">
		
		
		                    <div class="person-thumbnail">
		                        <a href="http://metu.edu.tr/~e186267" target="_blank"><img src="../resources/assets/images/content/EgeGorgun.jpg" alt="" title=""></a>
		                    </div>
		
		                    <a href="http://egegorgun.com/" target="_blank"><h4>Ege GÖRGÜN
		                        <span>a.k.a smartass</span>
		                    </h4></a>
		
		                    <p>Front End & Database Developer</p>
		
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
		            <div class="col-sm-6 col-md-3 animated activate fadeInUp" data-fx="fadeInUp">
		                <div class="personBox text-center">
		
		
		                    <div class="person-thumbnail">
		                        <a href="#" target="_blank"><img src="../resources/assets/images/content/02-home-team-04.jpg" alt="" title=""></a>
		                    </div>
		
		                    <a href="#" target="_blank"><h4>Eşref ÖZTOSUN
		                        <span>a.k.a hamburger</span>
		                    </h4></a>
		
		                    <p>Front End Developer</p>
		
		                    <ul class="socialNormal list-inline">
		                        <li><a data-original-title="Facebook" href="#" data-toggle="tooltip" title="" target="_blank"><i
		                                class="fa fa-fw fa-facebook"></i></a></li>
		                        <li><a data-original-title="LinkedIn" href="#" data-toggle="tooltip" title="" target="_blank"><i
		                                class="fa fa-fw fa-linkedin-square"></i></a></li>
		                        <li><a data-original-title="Google+" href="#" data-toggle="tooltip" title="" target="_blank"><i
		                                class="fa fa-fw fa-google-plus"></i></a></li>
		                        <li><a data-original-title="Skype" href="#" data-toggle="tooltip" title="" target="_blank"><i
		                                class="fa fa-fw fa-skype"></i></a></li>
		                    </ul>
		                </div>
		            </div>
		            <div class="col-sm-6 col-md-3 animated activate fadeInDown" data-fx="fadeInDown">
		                <div class="personBox text-center">
		
		
		                    <div class="person-thumbnail">
		                        <a href="#" target="_blank"><img src="../resources/assets/images/content/02-home-team-04.jpg" alt="" title=""></a>
		                    </div>
		
		                    <a href="#" target="_blank"><h4>İbrahim ÇOBANOĞLU
		                        <span>a.k.a harem</span>
		                    </h4></a>
		
		                    <p>Back End Developer</p>
		
		                    <ul class="socialNormal list-inline">
		                        <li><a data-original-title="Facebook" href="#" data-toggle="tooltip" title="" target="_blank"><i
		                                class="fa fa-fw fa-facebook"></i></a></li>
		                        <li><a data-original-title="LinkedIn" href="#" data-toggle="tooltip" title="" target="_blank"><i
		                                class="fa fa-fw fa-linkedin-square"></i></a></li>
		                        <li><a data-original-title="Google+" href="#" data-toggle="tooltip" title="" target="_blank"><i
		                                class="fa fa-fw fa-google-plus"></i></a></li>
		                        <li><a data-original-title="Skype" href="#" data-toggle="tooltip" title="" target="_blank"><i
		                                class="fa fa-fw fa-skype"></i></a></li>
		                    </ul>
		                </div>
		            </div>
		        </div>
			</div>
	    </div>
	</div>
	<%@include file="../includes/footer.jsp"%>
	
</body>

<%@include file="../includes/closingDivTagsForMobileViews.jsp"%>

</html>