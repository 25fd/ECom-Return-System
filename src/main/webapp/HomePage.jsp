<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
</head>
<body>
	<h1> Insurance Plan Project </h1>
	<form action="" method="post">
		
		<input type="button" value="Sign Up" onclick="redirectToRegistration()">
        <input type="button" value="Login" onclick="redirectToLogin()">
		
	<script>
        function redirectToRegistration() {
            window.location.href = "UserRegistration.jsp";
        }

        function redirectToLogin() {
            window.location.href = "LoginPage.jsp";
        }
    </script>
	</form>
</body>
</html>


          