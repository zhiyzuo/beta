<%@ page import="org.w3c.dom.css.RGBColor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Researcher Home Page</title>

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
		
		Object username = session.getAttribute("username");
		
		if(username == null) {
			username = request.getParameter("username");
		}
		
		rs = st.executeQuery("select * from beta.user_info where id = '" 
				+ username + "';");
		
		while(rs.next()) {	
			session.setAttribute("this_name", rs.getString(2) + " " + rs.getString(3));
			session.setAttribute("dept", rs.getString(4));
			session.setAttribute("phone", rs.getString(5));
			session.setAttribute("email", rs.getString(6));
			session.setAttribute("url", rs.getString(7));
			session.setAttribute("description", rs.getString(8));
		}
		
		con.close();
	%> 
	
	
	
	    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
      <div class="container">
      
        <h1><%=session.getAttribute("this_name") %></h1>
        <c:set var="if_researcher" value='<%=session.getAttribute("username")%>'></c:set>
        
		<!-- Button trigger modal -->
		<c:if test="${not empty if_researcher }">
			<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#myModal">
		  		View profile
			</button>
		</c:if>
		
		<c:if test="${not empty if_researcher }">
			<a class="btn btn-success btn-sm"  href=<%="index.jsp?username=" + session.getAttribute("username") %>>
				Home
			</a>
		</c:if>
		
		<c:if test="${empty if_researcher }">
			<a class="btn btn-success btn-sm"  href="index.jsp?">
				Home
			</a>
		</c:if>
		
		<c:if test="${not empty if_researcher }">
			<a class="btn btn-danger btn-sm"  href="logout.jsp">
				Logout
			</a>
		</c:if>
		
      </div>
    </div>
    
    
    
    <sql:setDataSource var="jdbc" driver="org.postgresql.Driver" 
    	    url="jdbc:postgresql://neuromancer.icts.uiowa.edu/institutional_repository"
        	user="zhiyzuo" password="gljfeef"/>
     
     <!-- Publications -->   	
	<sql:query var="pub" dataSource="${jdbc}">
		select title, article.pmid
		from medline.article where article.pmid in 
		(select pmid from medline.author where fore_name = 
		(select first_name from beta.user_info where id = CAST(? AS INTEGER)) and last_name =
		(select last_name from beta.user_info where id = CAST(? AS INTEGER)));
		<sql:param value="${param.username}"/>
		<sql:param value="${param.username}"/>
	</sql:query>
		
		
	<div class="container">
		<%@ include file="personbarchart.jsp" %>
	</div>
		
	<div class="container">
		<ul class="list-group">
			<li class= "list-group-item"> <h4>Articles Written</h4></li>
			<c:forEach items="${pub.rows}" var="result_row">
				<li class= "list-group-item"> 
					<a href="pub.jsp?pmid=<c:out value="${result_row.pmid}"/>">
						<c:out value="${result_row.title}"/><br>
					</a> 
				</li>
			</c:forEach>
		</ul>
	</div> 
	
	<br><br><br>
	
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