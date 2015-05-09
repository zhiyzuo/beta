<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Basic Author Search</title>

<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>


</head>
<body>

<sql:setDataSource var="jdbc" driver="org.postgresql.Driver" 
    	    url="jdbc:postgresql://neuromancer.icts.uiowa.edu/institutional_repository"
        	user="zhiyzuo" password="gljfeef"/>

	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
        	<div class="navbar-header">
          	<ul class="nav nav-tabs">
  			<li role="presentation"><a href="index.jsp">Home</a></li>
  			<li role="presentation"><a href="basicauthorsearch.jsp">Basic Search</a></li>
  			<li role="presentation"><a href="advancedauthorsearch.jsp">Advanced Search</a></li>
  			<li role="presentation" class="active"><a href="browse.jsp">Browse</a>
  			
  			<c:set var="current_user" value='<%=session.getAttribute("username") %>'/>
	        <c:if test="${empty current_user}">
  				<li role="presentation"><a href="login.jsp">Login</a></li>
  			</c:if>
  			</ul>
			</div>
		</div>
	</nav>


<nav class="navbar navbar-default navbar-fixed-bottom">
  <div class="container">
    <p class="text-muted navbar-right">&copy; Beta@UIowa 2015</p>
  </div>
</nav>
    


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</body>
</html>