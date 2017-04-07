<%@page session="true" %>
<%@page contentType="text/html; charset=UTF-8"%>
<script>
	
 	$(document).ready(function(){
 		denetciFotoGosterGenel();
 		
<%--		yukleniyor animasyonunu bitirebilmek icin--%>
 		$('#loading').hide();
 	});

	function dilYonlendirme(dilErisimKod){
		var url = $(location).attr('href');
		url = url.replace('#!','');
		url = url.replace('lang','syslng');
		if(url.indexOf('?')>=0){			
			url = url+'&lang='+dilErisimKod;
		}else{
			url = url+'?lang='+dilErisimKod;
		}
		location.href=""+url;
	}
	
	function denetciFotoGosterGenel(){
		
	}
</script>
<div class="navbar navbar-fixed-top">
	<div class="navbar-inner">
		<div class="container">
			<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>	
			</a>	
				
			<a href ="panel.htm" class="brand" href="#" style="color:black">
			<img src="../../img/logo.png" style="width:130px"><img/>
			</a>
			
			<div class="nav-collapse">
				<ul class="nav pull-right">
					<li class="dropdown">						
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" >
							<!--  <img id="image" src="profilFotografGoster.htm?id=${principal.kisi.id}" width="40" height="40"> -->
							<sec:authentication var="principal" property="principal" />
							<img src="http://icons.iconarchive.com/icons/custom-icon-design/mono-general-2/16/settings-icon.png" width="8" height="8">
								<fmt:message key="label.denetim.takip.dil"/><br/>						
							<b class="caret"></b>
						</a>
						<ul class="dropdown-menu">
							<li>
                        		<a href="javascript:void(0)" onclick="dilYonlendirme('tr')">
                        		<img src="https://img-gs.mncdn.com/cultureflags/4e96719805904a8b8dbc7ffefb79d4a6.jpeg"/>
<%--	                        		<div style=background-color:#ddd>--%>
	                        			<fmt:message key="Türkçe"/>
<%--	                        		</div>--%>
                        		</a>
                        	</li>
                        	<li>
                        		<a href="javascript:void(0)" onclick="dilYonlendirme('en')">
                        		<img src="https://img-gs.mncdn.com/cultureflags/7f36fba4479e476fb69798c98ac07659.jpeg"/>
<%--                        			<div style=background-color:#ddd>--%>
                        				<fmt:message key="English"/>
<%--                   					</div>--%>
                   				</a>
                        	</li>
						</ul>						
					</li>
				</ul>
			</div>
			
			<div class="nav-collapse" >
				<ul class="nav pull-right">
					<li class="dropdown">						
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" >
<%--							<c:set var="kisiSessiondaBulunan">--%>
<%--								<sec:authentication property="principal.kisi.listDenetciFotograf" />--%>
<%--							</c:set>--%>
						<img src="http://icons.iconarchive.com/icons/custom-icon-design/mono-general-2/16/settings-icon.png" width="16" height="16">
							<fmt:message key="label.ayarlar"/><br/>
							<b class="caret"></b>
						</a>
						<ul class="dropdown-menu">
							<c:forEach items="${principal.listDigerRoller}" var="rol"> 
								<li><a href="listKisiRollerGiris.htm?rol=${rol.ad}" >${rol.gorunenAdStr}</a></li>
							</c:forEach>
							
							<c:set var="loopSize" scope="session" value="${fn:length(principal.listDigerRoller)}"/>
							<c:if test="${loopSize > 0}">
								<hr/>
							</c:if>
							
							<li>
								<a href="profilyonlendir.htm"><fmt:message key="label.my.profile"/></a>
							</li>
							<sec:authorize access="hasAnyRole('ROL_BAS_DENETCI') or hasAnyRole('ROL_DENETCI')">
                       			<li>
                       				<a href="listDenetciDosya.htm"><fmt:message key="label.denetci.denetimdosya"/></a>
                       			</li>
                        	</sec:authorize>
                        	<li>
                        		<a href="changePassword.htm"><fmt:message key="label.change.password"/></a>
                        	</li>
                        	
                        	<hr/>
							<li>
								<a href="listYardim.htm"><fmt:message key="label.yardim"/></a>
							</li>
							<li>
								<a href="logout.htm"><fmt:message key="label.logout"/></a>
							</li>
						</ul>						
					</li>
				</ul>
			</div>
			
			<div class="nav-collapse" >
				<ul class="nav pull-right">
<%--						<img id="image" src="profilFotografGoster.htm?id=${principal.kisi.id}" width="40" height="40">--%>
<%--					<br/>--%>
						
							<a href="profilyonlendir.htm"><sec:authentication var="principal" property="principal"/>${principal.kisi.ad} ${principal.kisi.soyad}</a>
						
						<br/>
						<sec:authorize access="hasAnyRole('ROL_PLANLAMA_SORUMLUSU')">
								<li>
									<fmt:message key="label.planlama.sorumlusu"/>
								</li>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ROL_GENEL_MUDUR')">
								<li>
									<fmt:message key="label.genel.mudur"/>
								</li>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ROL_BELGELENDIRME_MUDURU')">
								<li>
									<fmt:message key="label.belgelendirme.muduru"/>
								</li>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ROL_BAS_DENETCI')">
								<li>
									<fmt:message key="label.bas.denetci"/>
								</li>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ROL_DENETCI')">
								<li>
									<fmt:message key="label.denetci"/>
								</li>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ROL_ADAY_DENETCI')">
								<li>
									<fmt:message key="label.aday.denetci"/>
								</li>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ROL_TEKNIK_UZMAN')">
								<li>
									<fmt:message key="label.teknik.uzman"/>
								</li>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ROL_MUHASEBE')">
								<li>
									<fmt:message key="label.muhasebe"/>
								</li>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ROL_KURULUS_YETKILISI')">
								<li>
									<fmt:message key="label.kurulus.yetkilisi"/>
								</li>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ROL_ADMIN')">
								<li>
									<fmt:message key="label.admin"/>
								</li>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ROL_BELGE_BASIM_SORUMLUSU')">
								<li>
									<fmt:message key="label.belgelendirme.sorumlusu"/>
								</li>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ROL_KOMITE_UYESI')">
								<li>
									<fmt:message key="label.komite.uyesi"/>
								</li>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ROL_ITIRAZ_SIKAYET_KOMITE_UYESI')">
								<li>
									<fmt:message key="label.itiraz.sikayet.komite.uyesi"/>
								</li>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ROL_TARAFSIZLIGI_SAGLAMA_KOMITE_UYESI')">
								<li>
									<fmt:message key="label.tarafsizligi.saglama.komite.uyesi"/>
								</li>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ROL_GENEL_MUDUR_YARDIMCISI')">
								<li>
									<fmt:message key="label.genel.mudur.yardimcisi"/>
								</li>
							</sec:authorize>
				</ul>
			</div>
			
			<div class="nav-collapse" >
				<ul class="nav pull-right">
					<c:choose>
						<c:when test="${!empty kisiSessiondaBulunan && !empty kisiSessiondaBulunan.listDenetciFotograf}">
							<img id="image" src="profilFotografGoster.htm?id=${principal.kisi.id}" width="40" height="40">
						</c:when>
						<c:otherwise>
							<img id="image" src="../../img/user.jpg" width="40" height="40">
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		
		
		
		</div> 
	</div> 
</div>