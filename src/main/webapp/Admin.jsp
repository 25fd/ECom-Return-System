<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin</title>
</head>
<body>
    <h1>Admin Dashboard</h1>
    <form action="DeleteProduct" method="post">
    <!-- Display Product Data -->
    <h3>Product Data:</h3>
    <table border="1">
        <tr>
            <th>Product ID</th>
            <th>Product Name</th>
            <th>Action</th>
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
                    int productId = resultSet.getInt("product_id");
                    String productName = resultSet.getString("product_name");
        %>
        <tr>
            <td><%= productId %></td>
            <td><%= productName %></td>
            <td>
                <a href="DeleteProduct?productid=<%= productId %>">Delete</a>
            </td>
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
    </table>
    </form>
    
    


<h3>Add Product:</h3>
<button onclick="window.location.href = 'AddProduct_Admin.jsp';">Add Product</button>
<br><br><br>
	



    
	<h3> User Data: </h3>
    <table border="1">
        <tr>
            <th>User ID</th>
            <th>User Name</th>
        </tr>
        <% 
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String dbURL = "jdbc:mysql://localhost:3306/Project";
                String dbUsername = "root";
                String dbPassword = "Sjhappy@9164";

                Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
                String selectUsersQuery = "SELECT * FROM Users";
                PreparedStatement usersStatement = connection.prepareStatement(selectUsersQuery);
                ResultSet usersResultSet = usersStatement.executeQuery();

                while (usersResultSet.next()) {
                    int userId = usersResultSet.getInt("user_id");
                    String userName = usersResultSet.getString("user_name");
        %>
        <tr>
            <td><%= userId %></td>
            <td><%= userName %></td>
        </tr>
        <%
                }
                usersResultSet.close();
                usersStatement.close();
                connection.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                response.sendRedirect("ErrorPage.jsp");
            }
        %>
    </table><br><br>
    
    <h3>Product Registration Data:</h3>
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
                Class.forName("com.mysql.jdbc.Driver");
                String dbURL = "jdbc:mysql://localhost:3306/Project";
                String dbUsername = "root";
                String dbPassword = "Sjhappy@9164";

                Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
                String selectRegistrationQuery = "SELECT * FROM ProductRegistration";
                PreparedStatement registrationStatement = connection.prepareStatement(selectRegistrationQuery);
                ResultSet registrationResultSet = registrationStatement.executeQuery();

                while (registrationResultSet.next()) {
                    int registrationId = registrationResultSet.getInt("registration_id");
                    int userId = registrationResultSet.getInt("user_id");
                    int productId = registrationResultSet.getInt("product_id");
                    String serialNo = registrationResultSet.getString("serial_no");
                    String purchaseDate = registrationResultSet.getString("purchase_date");
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
                registrationResultSet.close();
                registrationStatement.close();
                connection.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                response.sendRedirect("ErrorPage.jsp");
            }
        %>
    </table><br><br>
    
    <h3>Claim Data:</h3>
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
                Class.forName("com.mysql.jdbc.Driver");
                String dbURL = "jdbc:mysql://localhost:3306/Project";
                String dbUsername = "root";
                String dbPassword = "Sjhappy@9164";

                Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
                String selectClaimQuery = "SELECT * FROM Claim";
                PreparedStatement claimStatement = connection.prepareStatement(selectClaimQuery);
                ResultSet claimResultSet = claimStatement.executeQuery();

                while (claimResultSet.next()) {
                    int claimId = claimResultSet.getInt("claim_id");
                    int registrationId = claimResultSet.getInt("registration_id");
                    String claimDate = claimResultSet.getString("claim_date");
                    String description = claimResultSet.getString("description");
                    String status = claimResultSet.getString("status");

        %>
        <tr>
            <td><%= claimId %></td>
            <td><%= registrationId %></td>
            <td><%= claimDate %></td>
            <td><%= description %></td>
            <td>
            <form action="UpdateStatus" method="post">
                <input type="hidden" name="claimid" value="<%= claimId %>">
                <input type="text" name="status" value="<%= status %>">
                <input type="submit" value="Save">
            </form>
        </td>
        </tr>
        <%
                }
                claimResultSet.close();
                claimStatement.close();
                connection.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                response.sendRedirect("ErrorPage.jsp");
            }
        %>
    </table><br><br>
    


    
    <p><a href="LoginPage.jsp">Logout</a></p>
</body>
</html>
