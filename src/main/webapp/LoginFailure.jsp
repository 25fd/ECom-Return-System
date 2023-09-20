<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
<head>
<title>Login</title>
</head>
<body>
	<h1>Login</h1>
	<% if (request.getParameter("error") != null) { %>
        <p style="color: red;">Invalid credentials. Please try again.</p>
    <% } %>
	<form action="Login_Match" method="post">
		
			User ID: <input type="text" name="userid"><br><br>
			Username: <input type="text" name="username"><br><br>
			Password: <input type="password" name="password"><br><br>
			
			<input type="submit" value="Login">
		
	</form>
</body>
</html>
