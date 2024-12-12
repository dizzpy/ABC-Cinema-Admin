package com.example.adminmanagement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdParam = request.getParameter("user_id");
        if (userIdParam == null || userIdParam.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("User ID is required");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdParam);
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://mysql-abccinema.alwaysdata.net/abccinema_host", "abccinema", "EzATWsB6Zyfpz5");
                 PreparedStatement stmt = con.prepareStatement("DELETE FROM user_auth WHERE user_id = ?")) {
                stmt.setInt(1, userId);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("User deleted successfully");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("User not found");
                }
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid User ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("An error occurred while deleting the user");
        }
    }
}
