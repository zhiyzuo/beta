<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Advanced Search</title>

<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

</head>
<body>
	
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
        	<div class="navbar-header">
          	<ul class="nav nav-tabs">
  			<li role="presentation"><a href="index.jsp">Home</a></li>
  			<li role="presentation"><a href="basicsearch.jsp?search=${param.search}">Basic Search</a></li>
  			<li role="presentation" class="active"><a href="advancedsearch.jsp?search=${param.search}">Advanced Search</a></li>
  			<li role="presentation"><a href="browse.jsp">Browse</a>
  			
  			<c:set var="current_user" value='<%=session.getAttribute("username") %>'/>
	        <c:if test="${empty current_user}">
  				<li role="presentation"><a href="login.jsp">Login</a></li>
  			</c:if>
  			</ul>
			</div>
		</div>
	</nav>
	
	<c:if test="${param.search eq 'p'}">
	<br><br><br><br><br>
	<div class="container">
		<h2 align="center" style="margin-bottom:20px">Publication Advanced Search</h2>
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<form action="advancedsearch_p.jsp?pmid=${param.pmid}&title=${param.title}&issn=${param.issn}&volume=${param.volume}&issue=${param.issue}&pub_season=${param.pub_season}&pub_year=${param.pub_year}">	
					<div class="input-group">
					  <span class="input-group-addon" id="basic-addon1">PMID</span>
					  <input type="text" name="pmid" class="form-control" aria-describedby="basic-addon1">
					</div>
					<br>	
					<div class="input-group">
					  <span class="input-group-addon" id="basic-addon1">Title</span>
					  <input type="text" name="title" class="form-control" aria-describedby="basic-addon1">
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="basic-addon1">ISSN</span>
					  <input type="text" name="issn" class="form-control" aria-describedby="basic-addon1">
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="basic-addon1">Volume</span>
					  <input type="text" name="volume" class="form-control" aria-describedby="basic-addon1">
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="basic-addon1">Issue</span>
					  <input type="text" name="issue" class="form-control" aria-describedby="basic-addon1">
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="basic-addon1">Publication Searson</span>
					  <input type="text" name="pub_season" class="form-control" aria-describedby="basic-addon1">
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="basic-addon1">Publication Year</span>
					  <input type="text" name="pub_year" class="form-control" aria-describedby="basic-addon1">
					</div>
					<br>
					<div align="center">
						<button class="btn btn-info btn-lg" type="submit">
	                           Search <i class="glyphicon glyphicon-search"></i>
	                    </button>
                    </div>
				</form>
			</div>
			<div class="col-md-3"></div>
		</div>
	</div>
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