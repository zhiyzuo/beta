<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Demo</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">


</head>
<body>
 	<nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Beta</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
	        <c:set var="current_user" value='<%=session.getAttribute("username") %>'/>
	        <c:if test="${empty current_user}">
	          <form class="navbar-form navbar-right" action="logincheck.jsp" method="post">
	            <div class="form-group">
	              <input type="text" name="username" placeholder="Username" class="form-control" required autofocus>
	            </div>
	            <div class="form-group">
	              <input type="password" name="password"  placeholder="Password" class="form-control">
	            </div>
	            <button type="submit" class="btn btn-success">Sign in</button>
	          </form>
	        </c:if>
	        <c:if test="${not empty current_user}">
	        	<ul class="nav navbar-nav navbar-right">
	            	<li><a href=<%="./home.jsp?username=" + session.getAttribute("username") %>><%=session.getAttribute("name") %></a></li>
	            	<li><a href="./logout.jsp">Logout</a></li>
          		</ul>
	        </c:if>
        </div><!--/.navbar-collapse -->
        
      </div>
    </nav>

    <div class="jumbotron">
      <div class="container">
      	<c:if test='${not empty current_user}'>
        	<h1>Hello, <%=session.getAttribute("name") %></h1>
        </c:if>
        <c:if test='${empty current_user}'>
        	<h1>Hello, Guest</h1>
        </c:if>
        <p>This is a demo page for Beta Team Project.</p>
      </div>
    </div>

    <div class="container">
    <div class="row">
	<div class="col-md-4">
          <h2>Authors</h2>
        <form method= "post" action= "basicauthorsearch.jsp">
          <button type="submit" class="btn btn-default" value="a" name="search">Search</button>
    	</form>
    	<form method= "post" action= "browse.jsp">
    		<button type="submit" class="btn btn-default" value="a" name="browse">Browse</button>
    	</form>
    	</div>
    
    	
	
	<div class="col-md-4">
          <h2>Publications</h2>
        <form method= "post" action= "basicauthorsearch.jsp">
          <button type="submit" class="btn btn-default" value="p" name="search">Search</button>
        </form>
        <form method= "post" action= "browse.jsp">
    		<button type="submit" class="btn btn-default" value="p" name="browse">Browse</button>
    	</form>
	</div>
	
	
    <div class="col-md-4">
           <h2>Trials</h2>
        <form method= "post" action= "basicauthorsearch.jsp">	
          <button type="submit" class="btn btn-default" value="t" name="search">Search</button>
        </form>  
        <form method= "post" action= "browse.jsp">
    		<button type="submit" class="btn btn-default" value="t" name="browse">Browse</button>
    	</form>
    </div>
    </div>
	</div>


	
	
	<nav class="navbar navbar-default navbar-fixed-bottom">
	  <div class="container">
	    <p class="text-muted navbar-right">&copy; Beta@UIowa 2015</p>
	  </div>
	</nav>
    


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>


</body>
</html>
