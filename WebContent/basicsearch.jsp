<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Basic Search</title>

<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">


</head>
<body>

<sql:setDataSource var="jdbc" driver="org.postgresql.Driver" 
    	    url="jdbc:postgresql://neuromancer.icts.uiowa.edu/institutional_repository"
        	user="zhiyzuo" password="gljfeef"/>
        	
	<%@ include file="navbar_search.jsp" %>



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

<sql:query var="author" dataSource="${jdbc}">
			select id, first_name as first
			from beta.user_info 
			where last_name ILIKE ?
			order by first_name;
			<sql:param value="%${param.lastname}%"/>
</sql:query>

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
						<a href="home.jsp?username=<c:out value="${result_row.id}"/>&lastname=<c:out value="${author2.rowsByIndex[0][0]}"/>">
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

<c:if test="${not empty param.pubname}">	

<sql:query var="pub" dataSource="${jdbc}">
			SELECT subquery.title, 
			subquery.pmid as pmid,
			subquery.last_name
			FROM(
				SELECT article.pmid as pmid,
				title,  
				author.last_name as last_name
				FROM medline.author
				INNER JOIN beta.user_info
				ON medline.author.last_name = user_info.last_name
				AND author.initials = user_info.first_name
				INNER JOIN medline.article
				ON author.pmid = article.pmid
				GROUP BY article.pmid, author.last_name, title) as subquery
			WHERE title ILIKE ?
			ORDER BY subquery.pmid;
			<sql:param value="%${param.pubname}%"/>			
</sql:query>	

<br><br><br><br><br>
	<div class="container">
		<div class="row">
			<ul class="list-group">
				<li class= "list-group-item">Publication Title:</li>
				<c:forEach items="${pub.rows}" var="result_row">
					<a href="http://www.ncbi.nlm.nih.gov/pubmed/${result_row.pmid}">
						<li class= "list-group-item">
							${result_row.title}
						</li>
					</a>
				</c:forEach>
			</ul>
		</div>
	</div>



</c:if>

	

<c:if test="${param.search eq 't'}">


<br><br><br><br><br>
<form action="basicsearch.jsp?search=p">		
<div class="container">
	<div class="row">
        <div class="col-md-6">
    		<h2>Trial Keyword</h2>
            <div id="custom-search-input">
                <div class="input-group col-md-12">
                    <input type="text" class="form-control input-lg" name="keyword" placeholder="keyword" />
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

<c:if test="${not empty param.keyword}">	

<sql:query var="trial" dataSource="${jdbc}">
			SELECT subquery.textblock, 
			subquery.keyword,
			subquery.id
			FROM(
				SELECT keyword.keyword as keyword,
				textblock,
				overall_official.id as id 
				FROM clinical_trials.overall_official
				INNER JOIN beta.user_info
				ON      overall_official.last_name LIKE CONCAT(beta.user_info.last_name, '%')
				INNER JOIN clinical_trials.brief_summary
				ON overall_official.id = brief_summary.id
				INNER JOIN clinical_trials.keyword
				ON overall_official.id = keyword.id
				GROUP BY overall_official.id, keyword, textblock) as subquery
			WHERE keyword ILIKE ?
			ORDER BY subquery.keyword;
			<sql:param value="%${param.keyword}%"/>			
</sql:query>


<br><br><br><br><br>
	<div class="container">
		<div class="row">
			<ul class="list-group">
				<li class= "list-group-item">Trial Description:</li>
				<c:forEach items="${trial.rows}" var="result_row">
					<li class= "list-group-item">
							<c:out value="${result_row.id}"/>
							<c:out value="${result_row.textblock}"/>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>



</c:if>


		
	<%@ include file="navbar_footer.jsp" %>
    
    <script type="text/javascript">
    	document.getElementById("nav_basic").setAttribute("class", "active");
    </script>
	
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</body>
</html>