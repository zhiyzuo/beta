<%@ page language="java" contentType="text/html; charset=UTF-8"
       pageEncoding="UTF-8" errorPage="error.jsp"%>
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
	
<sql:query var="pub1" dataSource="${jdbc}">
			SELECT abstract_text
			FROM medline.abstr
			WHERE abstr.pmid = ?::integer
			<sql:param value="${param.pmid}"/>
</sql:query>
<sql:query var="pub2" dataSource="${jdbc}">
			SELECT title
			FROM medline.article
			WHERE article.pmid = ?::integer
			<sql:param value="${param.pmid}"/>
</sql:query>
<sql:query var="pub3" dataSource="${jdbc}">
			SELECT fore_name as first, last_name as last
			FROM medline.author
			WHERE author.pmid = ?::integer
			<sql:param value="${param.pmid}"/>
</sql:query>
<sql:query var="pub4" dataSource="${jdbc}">
			SELECT abstract_text
			FROM medline.other_abstract_text
			WHERE other_abstract_text.pmid = ?::integer
			<sql:param value="${param.pmid}"/>
</sql:query>
<sql:query var="pub5" dataSource="${jdbc}">
			SELECT keyword
			FROM medline.keyword
			WHERE keyword.pmid = ?::integer
			<sql:param value="${param.pmid}"/>
</sql:query>

<div class="container">
<div class="page-header">
  <h1>
  	<a href="http://www.ncbi.nlm.nih.gov/pubmed/<c:out value="${param.pmid}"/>">
  		<c:out value="${pub2.rowsByIndex[0][0]}"/>
  	</a>
  </h1>
  	<c:forEach items="${pub3.rows}" var="result_row">
  		<short><c:out value="${result_row.first}"/>&nbsp;<c:out value="${result_row.last}"/>,</short>
	</c:forEach>
</div>

<table class="table">
    <thead>
        <tr>
            <th>PMID</th>
            <th>Abstract</th>
        </tr>
    </thead>
    <tbody>
        	<tr>
            	<td>
            		<font color=#454149><c:out value="${param.pmid}"/></font>
        		</td>
           		<td>
            		<font color=#454149>
            			<c:forEach items="${pub1.rows}" var="result_row">
            				<c:out value="${result_row.abstract_text}"/>
            			</c:forEach>
            		</font>
            		<font color=#454149>
            			<c:forEach items="${pub4.rows}" var="result_row">
            				<c:out value="${result_row.abstract_text}"/>
           				</c:forEach>
           			</font>
           		</td>
           	</tr>
    </tbody>
</table>
</div>
	<div class="container">
		<div class="row">
			<ul class="list-group">
				<li class= "list-group-item">
					<h4>
					<span class="label label-primary">Keywords:</span>
					</h4>
				</li>
				<c:forEach items="${pub5.rows}" var="result_row">
						<li class= "list-group-item">
							<font color=#85A3C2>
							${result_row.keyword}
							</font>
						</li>
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