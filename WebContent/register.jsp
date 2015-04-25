<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Registeration</title>


</head>
<body>
This is a page for account creation.


<sql:setDataSource var="jdbc" driver="org.postgresql.Driver" 
    url="jdbc:postgresql://neuromancer.icts.uiowa.edu/institutional_repository"
    user="zhiyzuo" password="gljfeef"/>

<div>
	<form id="register_form" onsubmit="register()">
		First name: <input type="text" name="firstname">
		<br>
		Last name: <input type="text" name="lastname">
		<br>
		Username: <input type="text" name="username">
		<br>
		Password: <input type="password" name="password">
		<br>
		<input type="submit" value="Register" />
	</form>
</div>


<script type="text/javascript">

	function register() {
		var contents = document.getElementsByTagName("input");
		var firstname = contents[0].value;
		var lastname = contents[1].value;
		var username = contents[2].value;
		var password = contents[3].value;
		alert(firstname + " " + lastname + " " + username + " " + password);
		
	};
</script>


</body>
</html>