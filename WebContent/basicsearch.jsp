<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Basic Search</title>

<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">


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
  			<li role="presentation" class="active"><a href="basicsearch.jsp">Basic Search</a></li>
  			<li role="presentation"><a href="advancedsearch.jsp?search=${param.search}">Advanced Search</a></li>
  			<li role="presentation"><a href="browse.jsp">Browse</a>
  			
  			<c:set var="current_user" value='<%=session.getAttribute("username") %>'/>
	        <c:if test="${empty current_user}">
  				<li role="presentation"><a href="login.jsp">Login</a></li>
  			</c:if>
  			</ul>
			</div>
		</div>
	</nav>

 <sql:query var="author" dataSource="${jdbc}">
			select first_name as first
			from beta.user_info 
			where last_name ILIKE ?
			order by first_name;
			<sql:param value="%${param.lastname}%"/>
</sql:query>


<c:if test="${param.search eq 'a'}">	
<br><br><br><br><br>
<form action="basicsearch.jsp?search=a">		
<div class="container">
	<div class="row">
        <div class="col-md-6">
    		<h2>Author's Last Name</h2>
            <div id="custom-search-input">
                <div class="input-group col-md-12">
                    <input type="text" class="form-control input-lg" name="lastname" placeholder="Last Name" />
                    <span class="input-group-btn">
                        <button class="btn btn-info btn-lg" type="submit">
                            <i class="glyphicon glyphicon-search"></i>
                        </button>
                    </span>
                </div>
            </div>
        </div>
	</div>
</div>
</form>
</c:if>

<c:if test="${not empty param.lastname}">


<sql:query var="author2" dataSource="${jdbc}">
			select last_name as last
			from beta.user_info
			where first_name = ?
			order by last_name;
			<sql:param value="${author.rowsByIndex[0][0]}"/>
</sql:query>

	<br><br><br><br><br>
	<div class="container">
		<div class="row">
			<ul class="list-group">
				<li class= "list-group-item">Author:</li>
				<c:forEach items="${author.rows}" var="result_row">
					<li class= "list-group-item">
						<a href="basicsearchresult.jsp?first=<c:out value="${result_row.first}"/>&lastname=<c:out value="${author2.rowsByIndex[0][0]}"/>">
							<c:out value="${result_row.first}"/>
							&nbsp;
							<c:out value="${author2.rowsByIndex[0][0]}"/>
						</a></li>
				</c:forEach>
			</ul>
		</div>
	</div>
			
</c:if>

<c:if test="${param.search eq 'p'}">

<br><br><br><br><br>
<form action="basicsearch.jsp?search=p">		
<div class="container">
	<div class="row">
        <div class="col-md-6">
    		<h2>Publication Title</h2>
            <div id="custom-search-input">
                <div class="input-group col-md-12">
                    <input type="text" class="form-control input-lg" name="pubname" placeholder="Title" />
                    <span class="input-group-btn">
                        <button class="btn btn-info btn-lg" type="submit">
                            <i class="glyphicon glyphicon-search"></i>
                        </button>
                    </span>
                </div>
            </div>
        </div>
	</div>
</div>
</form>
</c:if>


		
<nav class="navbar navbar-default navbar-fixed-bottom">
  <div class="container">
    <p class="text-muted navbar-right">&copy; Beta@UIowa 2015</p>
  </div>
</nav>
    


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</body>
</html>