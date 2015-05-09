<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Basic Author Search</title>

<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>


</head>
<body>

<sql:setDataSource var="jdbc" driver="org.postgresql.Driver" 
    	    url="jdbc:postgresql://neuromancer.icts.uiowa.edu/institutional_repository"
        	user="zhiyzuo" password="gljfeef"/>


<%@ include file="navbar_search.jsp" %>
	


<br><br><br>
<c:if test="${param.search eq 'a'}">

<sql:query var="authorlist" dataSource="${jdbc}">
			select first_name as first, 
			last_name as last
			from beta.user_info
			order by last_name;
</sql:query>	

<div class="container">
<div class="row">
<br><br>
<ul class="list-group">
<h4 class="list-group-item-heading">Authors</h4>
  <c:forEach items="${authorlist.rows}" var="result_row">
  <li class="list-group-item">
  <c:out value="${result_row.first}"/>
  &nbsp;
  <c:out value="${result_row.last}"/>
  </c:forEach>
  </li>
</ul>
</div>
</div>

<br><br><br><br>

</c:if>

<c:if test="${param.search eq 'p'}">

<sql:query var="publist" dataSource="${jdbc}">
			SELECT article.pmid as pmid, 
			title,
			author.last_name as last_name
			FROM medline.author
			INNER JOIN beta.user_info
			ON author.last_name = user_info.last_name
			AND author.initials = user_info.first_name
			INNER JOIN medline.article
			ON author.pmid = article.pmid
			ORDER BY last_name, pmid;
</sql:query>



<div class="container">
	<div class="row">
<br><br>
		<ul class="list-group">
			<h4 class="list-group-item-heading">Publications</h4>
  				<c:forEach items="${publist.rows}" var="result_row">
  					<li class="list-group-item">
  						Author: <c:out value="${result_row.last_name}"/>
  						Title: <a href="http://www.ncbi.nlm.nih.gov/pubmed/<c:out value="${result_row.pmid}"/>">
  						<c:out value="${result_row.title}"/>
  						</a>
  					</li>
  				</c:forEach>
		</ul>
	</div>
</div>

<br><br><br><br>
</c:if>

<c:if test="${param.search eq 't'}">

<sql:query var="triallist" dataSource="${jdbc}">
			SELECT textblock,
			overall_official.id as id 
			FROM clinical_trials.overall_official
			INNER JOIN beta.user_info
			ON      overall_official.last_name LIKE CONCAT(beta.user_info.last_name, '%')
			INNER JOIN clinical_trials.brief_summary
			ON overall_official.id = brief_summary.id
			ORDER BY id;
</sql:query>

<div class="container">	
	<div class="row">
<br><br>
		<ul class="list-group">
			<h4 class="list-group-item-heading">Trials</h4>
  				<c:forEach items="${triallist.rows}" var="result_row">
  					<li class="list-group-item">
  						<c:out value="${result_row.id}"/>
 						&nbsp;
  						<c:out value="${result_row.textblock}"/>
  					</li>
  				</c:forEach>
		</ul>
	</div>
</div>

<br><br><br><br>

</c:if>
    

<%@ include file="navbar_footer.jsp" %>
    
    <script type="text/javascript">
    	document.getElementById("nav_basic").setAttribute("class", "active");
    </script>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</body>
</html>