<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Success</title>
</head>
<body>
    <h1>Login Successful</h1>
    <h2>Welcome, You have successfully logged in!</h2>
    
    <input type="button" value="Register Product" onclick="redirectToRegistration()">
    <input type="button" value="Claim Product" onclick="redirectToClaim()">
    
    <h3>Your Registered Products:</h3>
    <table border="1">
        <tr>
            <th>Registration ID</th>
            <th>User ID</th>
            <th>Product ID</th>
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
                
                String selectRegisteredProductsQuery = "SELECT * FROM ProductRegistration WHERE user_id = ?";
                PreparedStatement registeredProductsStatement = connection.prepareStatement(selectRegisteredProductsQuery);
                registeredProductsStatement.setInt(1, userId);
                ResultSet registeredProductsResultSet = registeredProductsStatement.executeQuery();

                while (registeredProductsResultSet.next()) {
                    int registrationId = registeredProductsResultSet.getInt("registration_id");
                    int productId = registeredProductsResultSet.getInt("product_id");
                    String serialNo = registeredProductsResultSet.getString("serial_no");
                    String purchaseDate = registeredProductsResultSet.getString("purchase_date");
        %>
        <tr>
            <td><%= registrationId %></td>
            <td><%= userId %></td>
            <td><%= productId %></td>
            <td><%= serialNo %></td>
            <td><%= purchaseDate %></td>
        </tr>
        <%
                }
                registeredProductsResultSet.close();
                registeredProductsStatement.close();
                connection.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                response.sendRedirect("ErrorPage.jsp");
            }
        %>
    </table><br><br>
    
    
    
<h3>Your Claimed Products:</h3>
<table border="1">
    <tr>
        <th>Claim ID</th>
        <th>Registration ID</th>
        <th>Claim Date</th>
        <th>Description</th>
        <th>Status</th>
        
    </tr>
    <% 
        try {
            int userId = (int) session.getAttribute("userid");
            
            Class.forName("com.mysql.jdbc.Driver");
            String dbURL = "jdbc:mysql://localhost:3306/Project";
            String dbUsername = "root";
            String dbPassword = "Sjhappy@9164";

            Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
            
            String selectClaimedProductsQuery = "SELECT * FROM Claim WHERE registration_id IN (SELECT registration_id FROM ProductRegistration WHERE user_id = ?)";
            PreparedStatement claimedProductsStatement = connection.prepareStatement(selectClaimedProductsQuery);
            claimedProductsStatement.setInt(1, userId);
            ResultSet claimedProductsResultSet = claimedProductsStatement.executeQuery();

            while (claimedProductsResultSet.next()) {
                int claimId = claimedProductsResultSet.getInt("claim_id");
                int registrationId = claimedProductsResultSet.getInt("registration_id");
                String claimDate = claimedProductsResultSet.getString("claim_date");
                String description = claimedProductsResultSet.getString("description");
                String status = claimedProductsResultSet.getString("status");

    %>
    <tr>
        <td><%= claimId %></td>
        <td><%= registrationId %></td>
        <td><%= claimDate %></td>
        <td><%= description %></td>
        <td><%= status %></td>
        
    </tr>
    <%
            }
            claimedProductsResultSet.close();
            claimedProductsStatement.close();
            
            String selectStatusQuery = "SELECT * FROM Claim WHERE claim_id IN (SELECT claim_id FROM Claim WHERE registration_id IN (SELECT registration_id FROM ProductRegistration WHERE user_id = ?))";
            PreparedStatement statusStatement = connection.prepareStatement(selectStatusQuery);
            statusStatement.setInt(1, userId);
            ResultSet statusResultSet = statusStatement.executeQuery();

    %>
</table><br><br>

<h3>Your Status Data:</h3>
<table border="1">
    <tr>
        <th>Claim ID</th>
        <th>Status</th>
    </tr>
    <%
        while (statusResultSet.next()) {
            int claimId = statusResultSet.getInt("claim_id");
            String status = statusResultSet.getString("status");
    %>
    <tr>
        <td><%= claimId %></td>
        <td><%= status %></td>
    </tr>
    <%
        }
        statusResultSet.close();
        statusStatement.close();
        connection.close();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        response.sendRedirect("ErrorPage.jsp");
    }
    %>
</table><br><br>

    
    <script>
        function redirectToRegistration() {
            window.location.href = "ProductRegistration.jsp";
        }

        function redirectToClaim() {
            window.location.href = "ProductClaim.jsp";
        }
    </script>
    <p><a href="HomePage.jsp">Logout</a></p>
</body>
</html>
