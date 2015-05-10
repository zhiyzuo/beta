<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Researcher Login Page</title>


<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet" href="./css/signin.css">


</head>
<body>

	<br><br>
    <div class="container">

      <form class="form-signin" action="./logincheck.jsp"  method="post">
        <h2 class="form-signin-heading">Please sign in</h2>
        <label for="username" class="sr-only">Username</label>
		<input type="text" id="username" name="username" placeholder="Username" class="form-control">
        <label for="password" class="sr-only">Password</label>
		<input type="password" id="password" name="password"  placeholder="Password" class="form-control">
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
      </form>

    </div> <!-- /container -->
    
    <%@ include file="navbar_footer.jsp" %>
    
    <script type="text/javascript">
    	document.getElementById("nav_login").setAttribute("class", "active");
    </script>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    
</body>
</html>