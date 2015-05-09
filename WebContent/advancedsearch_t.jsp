<%@page import="org.eclipse.jdt.internal.compiler.ast.IfStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ page import ="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="org.json.simple.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 

<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<title>Advanced Trial Search Results</title> 

</head> 
<body>
	 <%
	 
	 	Class.forName("org.postgresql.Driver");
		Connection con = DriverManager.getConnection(
				"jdbc:postgresql://neuromancer.icts.uiowa.edu/institutional_repository", 
				"zhiyzuo", "gljfeef");
		Statement st = con.createStatement();
		ResultSet rs;
		
		//TODO: deal with error/exception
		//TODO: search trials using people names
	 	String query = "select row_number() over(), org_study_id, nct_id, brief_title from clinical_trials.clinical_study where ";

	 	String[] textStrings = {"org_study_id", "nct_id", "brief_title", "source", "study_type"};
	 	for(int i = 0; i < textStrings.length; i++) {
	 		String this_key = request.getParameter(textStrings[i]); 
	 		if(this_key.length() > 0) {
	 			query += textStrings[i] + " LIKE '%" + this_key + "%' and";
	 		}
	 	}
	 	
	 	query = query.substring(0, query.length()-3) + " limit 1000;";

	 	try {
	 		rs = st.executeQuery(query);
	 		Map hashmap = new HashMap();
	 		List list = new LinkedList();
		    while (rs.next()) {
		    	try {
		    		hashmap.put("row", rs.getString(1));
		    		hashmap.put("org_study_id", rs.getString(2));
		    		hashmap.put("nct_id", rs.getString(3));
		    		hashmap.put("brief_title", rs.getString(4));
		    		list.add(hashmap);
		    		hashmap = new HashMap();
		    	}
		    	catch(Exception e) {
		    		out.println(query);
		    		//response.sendRedirect("error.jsp");
		    	}
			 	finally { 
			 		con.close();
			 	}
		 	}

		    session.setAttribute("advanced_search_trial", list);
	 	}catch(Exception e) {
	 		out.println(query);
	 		//response.sendRedirect("error.jsp");
	 		
	 	}
	 	finally {
	 		con.close();
	 	}
	 %> 
	 
	 <%@ include file="navbar_search.jsp" %>
	 	 
	 <br><br><br>
	 
	 <div class="container">
	 	<h2>Results (up to 1000 entries)</h2>
	 </div>

	<br><br>

	 <div class="container">
		<table class="table table-hover">
		    <thead>
		      <tr>
		        <th>#</th>
		        <th>Study ID</th>
		        <th>Title</th>
		      </tr>
		    </thead>
		    <tbody>
		    <c:forEach items='<%=session.getAttribute("advanced_search_trial") %>' var="map"> 		  
		      <tr>
		        <td>${map.row }</td>
		        <td>${map.org_study_id }</td>
		        <td>
		        	<a href="https://clinicaltrials.gov/ct2/show/<c:out value="${map.nct_id}"/>"> 
			  			<c:out value="${map.brief_title}"/>
					</a> 
				</td>
		      </tr>
		      </c:forEach>
		
		    </tbody>
	    </table>
	 </div>
	 
	 <%@ include file="navbar_footer.jsp" %>
	 
	 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</body> 
</html>