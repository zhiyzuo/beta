<%@page import="javax.sound.midi.Track"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="error.jsp"%> 
<%@ page import ="java.sql.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	 <%
	 	Class.forName("org.postgresql.Driver");
		Connection con = DriverManager.getConnection(
				"jdbc:postgresql://neuromancer.icts.uiowa.edu/institutional_repository", 
				"zhiyzuo", "gljfeef");
		Statement st = con.createStatement();
		
		String[] info = {"dept", "phone", "email", "url", "description"};
		String update_query = "update beta.user_info set ";
		for(int i = 0; i < info.length; i++) {
			update_query += info[i] + "='" + request.getParameter(info[i]) + "'";
			if(i != info.length - 1) {
				update_query += ", ";
			}
		}
		
		update_query += "where id = '" + session.getAttribute("username") + "';";
		
		// password in table user_demo;
		update_query += "update beta.user_demo set password = '" + 
				request.getParameter("password") + "' where id = '" + 
					session.getAttribute("username") + "';";
		
		try {
		 	st.executeUpdate(update_query);
		 	response.sendRedirect("home.jsp");
		}catch(Exception e) {
			response.sendRedirect("error.jsp");
		}
		finally {
			con.close();
		}
	 	
	 %> 
</body>
</html>