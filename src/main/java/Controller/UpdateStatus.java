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
@WebServlet("/UpdateStatus")
public class UpdateStatus extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UpdateStatus() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int claimId = Integer.parseInt(request.getParameter("claimid"));
        String newStatus = request.getParameter("status");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String dbURL = "jdbc:mysql://localhost:3306/Project";
            String dbUsername = "root";
            String dbPassword = "Sjhappy@9164";

            connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
            String updateStatusQuery = "UPDATE Claim SET status = ? WHERE claim_id = ?";
            preparedStatement = connection.prepareStatement(updateStatusQuery);
            preparedStatement.setString(1, newStatus);
            preparedStatement.setInt(2, claimId);
            preparedStatement.executeUpdate();

            response.sendRedirect("Admin.jsp");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("ErrorPage.jsp");
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
