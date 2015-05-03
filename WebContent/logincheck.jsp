<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ page import ="java.sql.*" %>
<html> 
<head> 

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<title>JSP Page</title> 

</head> 
<body>
	 <%
	 	Class.forName("org.postgresql.Driver");
		Connection con = DriverManager.getConnection(
				"jdbc:postgresql://neuromancer.icts.uiowa.edu/institutional_repository", 
				"zhiyzuo", "gljfeef");
		Statement st = con.createStatement();
		ResultSet rs;
		
	 	String username=request.getParameter("username"); 
	 	String password=request.getParameter("password"); 
	 	
	 	rs = st.executeQuery("select * from beta.user_demo where username='" + username + "' and password='" + password + "'");
	    if (rs.next()) {
	        session.setAttribute("username", username);
	        response.sendRedirect("home.jsp");
	        con.close();
	    } 
	 	else { 
	 		response.sendRedirect("error.jsp");
	 		con.close();
	 	}
	    	
	 %> 
</body> 
</html>