<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Basic Author Search</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

</head>
<body>

<sql:setDataSource var="jdbc" driver="org.postgresql.Driver" 
    	    url="jdbc:postgresql://neuromancer.icts.uiowa.edu/institutional_repository"
        	user="demo" password="demo"/>

	<%@ include file="navbar_search.jsp" %>

        
	<sql:query var="title" dataSource="${jdbc}">
		select title,article.pmid
		from medline.article,medline.author 
		where article.pmid=author.pmid 
		and fore_name = ?
		and last_name = ? 
		order by title;
		<sql:param value="${param.first}"/>
		<sql:param value="${param.lastname}"/>
	</sql:query>

		
		<br><br><br>
		<div class="container">
			<ul class="list-group">
				<li class= "list-group-item"> <h4>Articles Written By ${param.first} ${param.lastname}:</h4></li>
				<c:forEach items="${title.rows}" var="result_row">
					<li class= "list-group-item"> 
						<a href="http://www.ncbi.nlm.nih.gov/pubmed/<c:out value="${result_row.pmid}"/>">
							<c:out value="${result_row.title}"/><br>
						</a> 
					</li>
				</c:forEach>
			</ul>
		</div>
		
	<%@ include file="navbar_footer.jsp" %>
	
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

</body>
</html>