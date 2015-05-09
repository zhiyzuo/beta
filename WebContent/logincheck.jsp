<%@page import="org.eclipse.jdt.internal.compiler.ast.IfStatement"%>
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
	    	ResultSet rs_info = st.executeQuery("select last_name, first_name from beta.user_info where id = '" 
	    			+ username + "';");
	    	if(rs_info.next()) {
	    		session.setAttribute("name", rs_info.getString(1) + ", " + rs_info.getString(2));
	    		session.setAttribute("first_name", rs_info.getString(2));
	    		session.setAttribute("last_name", rs_info.getString(1));
	    	}
	    	
	    	
	        session.setAttribute("username", username);
	        session.setAttribute("password", password);
	        session.removeAttribute("guest");
	        response.sendRedirect("index.jsp?username=" + username);
	        con.close();
	    } 
	 	else { 
	 		response.sendRedirect("error.jsp");
	 		con.close();
	 	}
	    	
	 %> 
</body> 
</html>