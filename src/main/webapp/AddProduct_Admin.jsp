<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Product: Admin</title>
</head>
<body>
    <h1>Add New Product</h1>
    
    <form action="AddProduct" method="post">
        Product ID: <input type="text" name="productid"><br><br>
        Product Name: <input type="text" name="productname"><br><br>
        <input type="submit" value="Submit">
    </form>
    
    <p><a href="Admin.jsp">Dashboard</a></p>
</body>
</html>
