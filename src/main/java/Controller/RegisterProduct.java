package Controller;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterProduct")
public class RegisterProduct extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String registrationIdStr = request.getParameter("registrationid");
        String userIdStr = request.getParameter("userid");
        String productIdStr = request.getParameter("productid");
        String serialNo = request.getParameter("serialno");
        String purchaseDate = request.getParameter("purchasedate");
        
        
        int registrationid = Integer.parseInt(registrationIdStr);
        int userid = Integer.parseInt(userIdStr);
        int productid = Integer.parseInt(productIdStr);


        String dbURL = "jdbc:mysql://localhost:3306/Project";
        String dbUsername = "root";
        String dbPassword = "Sjhappy@9164";

        try {
            Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

            String insertQuery = "INSERT INTO ProductRegistration (registration_id, user_id, product_id, serial_no, purchase_date) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);
            preparedStatement.setInt(1, registrationid);
            preparedStatement.setInt(2, userid);
            preparedStatement.setInt(3, productid);
            preparedStatement.setString(4, serialNo);
            preparedStatement.setString(5, purchaseDate);
            preparedStatement.executeUpdate();

            preparedStatement.close();
            connection.close();

            response.sendRedirect("ProductRegisterSuccess.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("ProductRegistrationFailure.jsp");
        }
    }
}
