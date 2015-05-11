<%@page import="org.apache.catalina.util.Enumerator"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Logout</title>
</head>
<body>
<style>
body{
	background-color:cyan;
	}
</style>
	<% 
	
	Enumeration e = session.getAttributeNames();
	
	while(e.hasMoreElements()) {
		session.removeAttribute(e.nextElement().toString()); 
	}

		session.invalidate(); 
	%> 
	<h1 align="center"><mark>Logout Successful!</mark></h1> 
	
	<form name="redirect">
		<center>
			You will be redirected to the home page in<br><br>
			<input type="text" size="3" name="countdown" readonly>	
			seconds <br><br>
			<a href="./index.jsp">Go to home page now...</a>
		</center>
	</form>
	
	<%@ include file="navbar_footer.jsp" %>
	

	<script>
	
		//change below target URL to your own
		var targetURL="./index.jsp";
		//change the second to start counting down from
		var countdownfrom = 5;
		
		var currentsecond = document.redirect.countdown.value= countdownfrom + 1;
		
		function countredirect(){
		if (currentsecond!=1){
			currentsecond -= 1;
			document.redirect.countdown.value=currentsecond;
		}
		else{
			window.location = targetURL;
			return;
		}
			setTimeout("countredirect()",1000);
		}
		
		countredirect();
		
	</script>

</body>
</html>