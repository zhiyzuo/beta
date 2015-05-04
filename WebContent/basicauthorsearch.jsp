<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Basic Author Search</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

</head>
<body>

<sql:setDataSource var="jdbc" driver="org.postgresql.Driver" 
    	    url="jdbc:postgresql://neuromancer.icts.uiowa.edu/institutional_repository"
        	user="zhiyzuo" password="gljfeef"/>

	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
        	<div class="navbar-header">
          	<ul class="nav nav-tabs">
  			<li role="presentation" class="active"><a href="index.jsp">Home</a></li>
  			<li role="presentation"><a href="advancedauthorsearch.jsp">Advanced Search</a></li>
  			<li role="presentation"><a href="login.jsp">Login</a></li>
			</ul>
			</div>
		</div>
	</nav>
        	
<br><br><br>

		<sql:query var="author" dataSource="${jdbc}">
			select first_name as first
			from beta.user_info 
			where last_name = ?
			order by first_name;
			<sql:param value="${param.lastname}"/>
		</sql:query>
		
		<div class="container">
			<div class="row">
				<form action="basicauthorsearch.jsp" class="form-inline">
				  <div class="form-group">
				    <label for="lname">Author's Last Name</label>
				    <input type="text" class="form-control" name="lastname" placeholder="name">
				  </div>
				  <button type="submit" class="btn btn-default">Search</button>
				</form>
			</div>
			
			<div class="row">
			<br><br>
			<ul class="list-group">
			<li class= "list-group-item"> <h4>Author:</h4></li>
			<c:forEach items="${author.rows}" var="result_row">
				<li class= "list-group-item">
					<a href="basicauthorsearchresults.jsp?first=<c:out value="${result_row.first}"/>&lastname=<c:out value="${param.lastname}"/>">
						<c:out value="${result_row.first}"/>
						&nbsp;
						<c:out value="${param.lastname}"/>
					</a></li>
			</c:forEach>
			</ul>
			</div>
		</div>
		

</body>
</html>