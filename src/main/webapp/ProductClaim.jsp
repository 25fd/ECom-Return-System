<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Claimed Products</title>
</head>
<body>
    <h1>Claim Your Product</h1>
    
    <h3>Your Registered Products:</h3>
    <table border="1">
        <tr>
            <th>Registration ID</th>
            <th>Product ID</th>
            <th>Product Name</th>
            <th>Serial No</th>
            <th>Purchase Date</th>
        </tr>
        <% 
            try {
                int userId = (int) session.getAttribute("userid");
                
                Class.forName("com.mysql.jdbc.Driver");
                String dbURL = "jdbc:mysql://localhost:3306/Project";
                String dbUsername = "root";
                String dbPassword = "Sjhappy@9164";

                Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
                
                String selectClaimedProductsQuery = "SELECT * FROM ProductRegistration WHERE user_id = ?";
                PreparedStatement claimedProductsStatement = connection.prepareStatement(selectClaimedProductsQuery);
                claimedProductsStatement.setInt(1, userId);
                ResultSet claimedProductsResultSet = claimedProductsStatement.executeQuery();

                while (claimedProductsResultSet.next()) {
                    int registrationId = claimedProductsResultSet.getInt("registration_id");
                    int productId = claimedProductsResultSet.getInt("product_id");
                    String serialNo = claimedProductsResultSet.getString("serial_no");
                    String purchaseDate = claimedProductsResultSet.getString("purchase_date");
                    
                    String selectProductNameQuery = "SELECT product_name FROM Product WHERE product_id = ?";
                    PreparedStatement productNameStatement = connection.prepareStatement(selectProductNameQuery);
                    productNameStatement.setInt(1, productId);
                    ResultSet productNameResultSet = productNameStatement.executeQuery();
                    String productName = "";
                    if (productNameResultSet.next()) {
                        productName = productNameResultSet.getString("product_name");
                    }
                    productNameResultSet.close();
                    productNameStatement.close();
        %>
        <tr>
            <td><%= registrationId %></td>
            <td><%= productId %></td>
            <td><%= productName %></td>
            <td><%= serialNo %></td>
            <td><%= purchaseDate %></td>
        </tr>
        <%
                }
                claimedProductsResultSet.close();
                claimedProductsStatement.close();
                connection.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                response.sendRedirect("ErrorPage.jsp");
            }
        %>
    </table><br><br>
    
    <h3> Fill Out this form to Claim your Product:</h3>
    <form action="Claim_Store" method="post"> 
    	Claim ID: <input type = "text" name = "claimid"><br><br>
    	Registration ID: <input type = "text" name = "registrationid"><br><br>
    	Claim Date: <input type = "date" name = "claimdate"><br><br>
    	Description: <input type = "text" name = "description"><br><br>
    	<input type = "submit" value = "Claim"><br><br>
    </form>
    
    <p><a href="LoginSuccess.jsp">Back to Home</a></p>
</body>
</html>
