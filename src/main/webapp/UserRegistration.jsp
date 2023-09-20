<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
<head>
<title>User Registration</title>
</head>
<body>
	<h1>User Registration</h1>
	<form action="UserRegistration_Store" method="post">
		<fieldset>
			User ID: <input type = "text" name="userid"><br><br>
			Username: <input type = "text" name="username"><br><br>
			Password: <input type="password" name="password"><br><br>
			Email ID: <input type = "email" name="email"><br><br>
			Phone Number: <input type = "text" name="phoneno"><br><br>
			Name: <input type = "text" name="name"><br><br>
			<input type="submit" value="Sign Up">
			<p><a href="HomePage.jsp">Dashboard</a></p>
		</fieldset>
	</form>
</body>
</html>