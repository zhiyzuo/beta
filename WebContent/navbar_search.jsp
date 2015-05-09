<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

</head>
<body>
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
  			<li role="presentation" id="nav_browse"><a href="browse.jsp?search=${param.search}">Browse</a></li>
	        <c:if test="${empty current_user}">
  				<li role="presentation" id="nav_login"><a href="login.jsp">Login</a></li>
  			</c:if>
  			</ul>
			</div>
		</div>
	</nav>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</body>
</html>