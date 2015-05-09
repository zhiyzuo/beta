<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ page import ="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=session.getAttribute("name")%>'s Home Page</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<script type="text/javascript">

function resetForm($form) {
    $form.find('input:text, textarea').not("input[name='username']").val('');
}

</script>

</head>
<body>

	<% 
		Class.forName("org.postgresql.Driver");
		Connection con = DriverManager.getConnection(
				"jdbc:postgresql://neuromancer.icts.uiowa.edu/institutional_repository", 
				"zhiyzuo", "gljfeef");
		Statement st = con.createStatement();
		ResultSet rs;
		
		rs = st.executeQuery("select * from beta.user_info where id = '" 
			+ session.getAttribute("username") + "';");
		while(rs.next()) {	
			session.setAttribute("dept", rs.getString(4));
			session.setAttribute("phone", rs.getString(5));
			session.setAttribute("email", rs.getString(6));
			session.setAttribute("url", rs.getString(7));
			session.setAttribute("description", rs.getString(8));
		}
		
		con.close();
	%> 
	
	<c:set var="guest" value='${session.getAttribute("guest")}'></c:set>

	    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
      <div class="container">
        <h1>Welcome: <%=session.getAttribute("name")%></h1>	
		<!-- Button trigger modal -->
		<c:if test="empty ${guest }">
		<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#myModal">
	  		View profile
		</button>
		</c:if>
		<a class="btn btn-success btn-sm"  href=<%="index.jsp?username=" + session.getAttribute("username") %>>
			Home
		</a>
		<a class="btn btn-danger btn-sm"  href="logout.jsp" %>
			Logout
		</a>
      </div>
    </div>
	
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Profile: <%=session.getAttribute("name")%></h4>
	      </div>
	      <div class="modal-body">
	        <form id="profileForm" action="updateprofile.jsp" method="post">
	        	  <label for="username">Username</label>
	              <input type="text" id="username" name="username" value=<%=session.getAttribute("username")%> class="form-control" readonly>
	              <label for="password">Password</label>
	              <input type="text" id="password" name="password" value=<%=session.getAttribute("password")%> class="form-control">
	              <label for="dept">Department</label>
	              <input type="text" id="dept" name="dept" value=<%=session.getAttribute("dept")%> class="form-control">
	              <label for="phone">Phone</label>
	              <input type="text" id="phone" name="phone" value=<%=session.getAttribute("phone")%> class="form-control">
	              <label for="email">Email</label>
	              <input type="text" id="email" name="email" value=<%=session.getAttribute("email")%> class="form-control">
	              <label for="url">Personal Webpage</label>
	              <input type="text" id="url" name="url"  value=<%=session.getAttribute("url")%> class="form-control">
	              <label for="description">Description</label>
	              <textarea id="description" name="description" class="form-control"><%=session.getAttribute("description")%> </textarea>
          	</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" id="clearButton" class="btn btn-danger">Clear</button>
	        <button type="button" id="resetButton" class="btn btn-warning">Reset</button>
	        <button type="submit" id="submitButton" class="btn btn-primary">Save changes</button>
	      </div>
	    </div>
	  </div>
	</div>

	<br>


	<%@ include file="navbar_footer.jsp" %>
	
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

	<script>
	  $('#clearButton').on('click', function () {
		  resetForm($('#profileForm'));
	  })
	  
	  $('#resetButton').on('click', function () {
		  $("#profileForm").trigger('reset');
	  })  
	  $('#submitButton').on('click', function () {
		  $("#profileForm").trigger('submit');
	  })  
	</script>

</body>
</html>