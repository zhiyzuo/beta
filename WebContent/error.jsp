<%@ page language="java" isErrorPage="true" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Error Page</title>
</head>
<body>

	<h1 align="center">Some Error has occurred, please try again later...</h1>
	<br>

	<form name="redirect">
		<center>
			You will be redirected to home page in<br><br>
			<input type="text" size="3" name="countdown" readonly>	
			seconds
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