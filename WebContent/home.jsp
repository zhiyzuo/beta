<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"   errorPage="error.jsp"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home</title>
</head>
<body>
<br/><br/><br/><br/><br/> 
<center> 
	<% 
		Class.forName("org.postgresql.Driver");
		Connection con = DriverManager.getConnection(
				"jdbc:postgresql://neuromancer.icts.uiowa.edu/institutional_repository", 
				"zhiyzuo", "gljfeef");
		Statement st = con.createStatement();
		ResultSet rs;
		
		rs = st.executeQuery("select first_name, last_name from beta.user_info where id = '" 
			+ session.getAttribute("username") + "';");
		while(rs.next()) {
			session.setAttribute("name", rs.getString(1) + rs.getString(2));
		}
		
		con.close();
		//System.out.println("Hello "+ user); 
	%> 

	
	<h1>Welcome, <%=session.getAttribute("name")%></h1>	

	<a href="logout.jsp">Logout</a> 
</center>
</body>
</html>