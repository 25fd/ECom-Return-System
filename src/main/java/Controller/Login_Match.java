package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Login_Match")
public class Login_Match extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public Login_Match() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String useridStr = request.getParameter("userid");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        int userid = Integer.parseInt(useridStr);

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String dbURL = "jdbc:mysql://localhost:3306/Project";
            String dbUsername = "root";
            String dbPassword = "Sjhappy@9164";

            connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

            String selectQuery = "SELECT * FROM Users WHERE user_id = ? AND user_name = ? AND password = ?";
            preparedStatement = connection.prepareStatement(selectQuery);
            preparedStatement.setInt(1, userid);
            preparedStatement.setString(2, username);
            preparedStatement.setString(3, password);

            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int userId = resultSet.getInt("user_id");
                String userType = resultSet.getString("user_type");

                HttpSession session = request.getSession();
                session.setAttribute("userid", userId);

                if ("admin".equals(userType)) {
                    response.sendRedirect("Admin.jsp");
                } else {
                    response.sendRedirect("LoginSuccess.jsp");
                }
            } else {
                response.sendRedirect("LoginFailure.jsp?error=1");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("LoginFailure.jsp?error=1");
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
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
