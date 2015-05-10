<%@page import="org.eclipse.jdt.internal.compiler.ast.IfStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="error.jsp"%> 
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

<title>Advanced Author Search Results</title> 

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
	 	String query = "select row_number() over(), fore_name as first_name, last_name from medline.author where ";

	 	String[] textStrings = {"fore_name", "last_name"};
	 	for(int i = 0; i < textStrings.length; i++) {
	 		String this_key = request.getParameter(textStrings[i]); 
	 		if(this_key.length() > 0) {
	 			query += textStrings[i] + " LIKE '%" + this_key + "%' and";
	 		}
	 	}
	 	
	 	query = query.substring(0, query.length()-3);
	 	query += " limit 1000;";
	 	
/* 	 	session.setAttribute("query", query); */

	 	try {
	 		rs = st.executeQuery(query);
	 		Map hashmap = new HashMap();
	 		List list = new LinkedList();
		    while (rs.next()) {
		    	try {
		    		hashmap.put("row", rs.getString(1));
		    		hashmap.put("first_name", rs.getString(2));
		    		hashmap.put("last_name", rs.getString(3));
		    		list.add(hashmap);
		    		hashmap = new HashMap();
		    	}
		    	catch(Exception e) {
		    		out.println(query);
		    		/* response.sendRedirect("error.jsp"); */
		    	}
			 	finally { 
			 		con.close();
			 	}
		 	}

		    session.setAttribute("advanced_search_author", list);
	 	}catch(Exception e) {
	 		/* response.sendRedirect("error.jsp"); */
	 		out.println(query);
	 	}
	 	finally {
	 		con.close();
	 	}
	 %> 
	 <%@ include file="navbar_search.jsp" %>
	 	 
	 <br><br><br>
	 
	 <div class="container">
	 	<h2>Results (limited to 1000 entries)</h2>
<%-- 	 	<h2><%=session.getAttribute("query") %></h2> --%>
	 </div>

	<br><br>
	
	 <div class="container">
		<table class="table table-hover">
		    <thead>
		      <tr>
		        <th>#</th>
		        <th>Name</th>
		      </tr>
		    </thead>
		    <tbody>
		    <c:forEach items='<%=session.getAttribute("advanced_search_author") %>' var="map"> 		  
		      <tr>
		        <td>${map.row }</td>
		        <td>${map.first_name } ${map.last_name }</td>
		      </tr>
		      </c:forEach>
		
		    </tbody>
	    </table>
	 </div>
	 
	 <%@ include file="navbar_footer.jsp" %>
	 
	 <script type="text/javascript">
    	document.getElementById("nav_advanced").setAttribute("class", "active");
    </script>
	 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</body> 
</html>