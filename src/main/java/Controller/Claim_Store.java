package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Claim_Store") 
public class Claim_Store extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public Claim_Store() {
        super();
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	 String claimIdStr = request.getParameter("claimid");
         String registrationIdStr = request.getParameter("registrationid");
         String claimDate = request.getParameter("claimdate");
         String description = request.getParameter("description");
         
         int claimId = Integer.parseInt(claimIdStr);
         int registrationId = Integer.parseInt(registrationIdStr);
         
         String dbURL = "jdbc:mysql://localhost:3306/Project";
         String dbUsername = "root";
         String dbPassword = "Sjhappy@9164";
         
         try {
             Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

             String insertQuery = "INSERT INTO Claim (claim_id, registration_id, claim_date, description) VALUES (?, ?, ?, ?)";
             PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);
             preparedStatement.setInt(1, claimId);
             preparedStatement.setInt(2, registrationId);
             preparedStatement.setString(3, claimDate);
             preparedStatement.setString(4, description);
             preparedStatement.executeUpdate();

             preparedStatement.close();
             connection.close();

             response.sendRedirect("LoginSuccess.jsp");

         } catch (SQLException e) {
             e.printStackTrace();
             response.sendRedirect("ErrorPage.jsp");
         }
    	
    }
}









  
