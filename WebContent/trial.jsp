<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Browse</title>

<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
</head>
<body>

<div class="spinner">
    Loading...
</div>

<sql:setDataSource var="jdbc" driver="org.postgresql.Driver" 
    	    url="jdbc:postgresql://neuromancer.icts.uiowa.edu/institutional_repository"
        	user="zhiyzuo" password="gljfeef"/>


<%@ include file="navbar_search.jsp" %>
	
<sql:query var="trial" dataSource="${jdbc}">
			SELECT textblock as description
			FROM clinical_trials.detailed_description
			WHERE detailed_description.id = ?::integer
			<sql:param value="${param.id}"/>
</sql:query>
<sql:query var="trial2" dataSource="${jdbc}">
			SELECT keyword
			FROM clinical_trials.keyword
			WHERE keyword.id = ?::integer
			<sql:param value="${param.id}"/>
</sql:query>
<sql:query var="trial3" dataSource="${jdbc}">
			SELECT last_name
			FROM clinical_trials.overall_official
			WHERE overall_official.id = ?::integer
			<sql:param value="${param.id}"/>
</sql:query>
<sql:query var="trial4" dataSource="${jdbc}">
			SELECT brief_title
			FROM clinical_trials.clinical_study
			WHERE clinical_study.id = ?::integer
			<sql:param value="${param.id}"/>
</sql:query>




<div class="page-header">
  <h1><c:out value="${trial4.rowsByIndex[0][0]}"/></h1><short><c:out value="${trial3.rowsByIndex[0][0]}"/></short>
</div>

<table class="table">
    <thead>
        <tr>
            <th>Trial Number</th>
            <th>Detailed Description</th>
        </tr>
    </thead>
    <tbody>
        	<c:forEach items="${trial.rows}" var="result_row">
        		<tr>
            		<td><c:out value="${param.id}"/></td>
            		<td><c:out value="${result_row.description}"/></td>
            	</tr>
            </c:forEach>
    </tbody>
</table>
	<div class="container">
		<div class="row">
			<ul class="list-group">
				<li class= "list-group-item"><h4>Keywords:</h4></li>
				<c:forEach items="${trial2.rows}" var="result_row">
						<li class= "list-group-item">
							${result_row.keyword}
						</li>
					</a>
				</c:forEach>
			</ul>
		</div>
	</div>
<br><br>



<%@ include file="navbar_footer.jsp" %>

    <script type="text/javascript">
    	document.getElementById("nav_browse").setAttribute("class", "active");
    </script>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</body>
</html>