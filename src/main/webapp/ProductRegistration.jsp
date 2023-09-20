<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Registration</title>
</head>
<body>
    <h1>Product Registration</h1>
    
    <h2>Register Products from this Table</h2>
    <table border="1">
        <tr>
            <th>Product ID</th>
            <th>Product Name</th>
        </tr>
        <% 
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String dbURL = "jdbc:mysql://localhost:3306/Project";
                String dbUsername = "root";
                String dbPassword = "Sjhappy@9164";

                Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
                String selectQuery = "SELECT * FROM Product";
                PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
                ResultSet resultSet = preparedStatement.executeQuery();

                while (resultSet.next()) {
                    int product_id = resultSet.getInt("product_id");
                    String product_name = resultSet.getString("product_name");
        %>
        <tr>
            <td><%= product_id %></td>
            <td><%= product_name %></td>
        </tr>
        <%
                }
                resultSet.close();
                preparedStatement.close();
                connection.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                response.sendRedirect("ErrorPage.jsp");
            }
        %>
    </table><br><br>

    <h2>Registration Form</h2>
    <form action="RegisterProduct" method="post">
        Registration ID: <input type="text" name="registrationid"><br><br>
        
        <input type="hidden" name="userid" value="<%= session.getAttribute("userid") %>">
        
        Product Name: 
        <select name="productid">
            <% 
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    String dbURL = "jdbc:mysql://localhost:3306/Project";
                    String dbUsername = "root";
                    String dbPassword = "Sjhappy@9164";

                    Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
                    String selectProductsQuery = "SELECT product_id, product_name FROM Product";
                    PreparedStatement productStatement = connection.prepareStatement(selectProductsQuery);
                    ResultSet productResultSet = productStatement.executeQuery();

                    while (productResultSet.next()) {
                        int productId = productResultSet.getInt("product_id");
                        String productName = productResultSet.getString("product_name");
            %>
            <option value="<%= productId %>"><%= productName %></option>
            <%
                    }
                    productResultSet.close();
                    productStatement.close();
                    connection.close();
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                    response.sendRedirect("ErrorPage.jsp");
                }
            %>
        </select><br><br>
        Serial No: <input type="text" name="serialno"><br><br>
        Purchase Date: <input type="date" name="purchasedate"><br><br>
        <input type="submit" value="Register">
    </form>
    
    <p><a href="HomePage.jsp">Back to Home</a></p>
</body>
</html>
