
	<c:set var="current_user" value='<%=session.getAttribute("username") %>'></c:set>
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
        	<div class="navbar-header">
          	<ul class="nav nav-tabs">
  			<c:if test="${empty current_user}">
  			<li role="presentation"><a href="index.jsp">Home</a></li>
  			</c:if>
  			<c:if test="${not empty current_user}">
  			<li role="presentation" id="nav_home"><a href="index.jsp?username=${current_user}">Home</a></li>
  			</c:if>
  			<li role="presentation" id="nav_basic"><a href="basicsearch.jsp?search=${param.search}">Basic Search</a></li>
  			<li role="presentation" id="nav_advanced"><a href="advancedsearch.jsp?search=${param.search}">Advanced Search</a></li>
  			<li role="presentation" id="nav_browse"><a href="browse.jsp">Browse</a>
	        <c:if test="${empty current_user}">
  				<li role="presentation" id="nav_login"><a href="login.jsp">Login</a></li>
  			</c:if>
  			</ul>
			</div>
		</div>
	</nav>
