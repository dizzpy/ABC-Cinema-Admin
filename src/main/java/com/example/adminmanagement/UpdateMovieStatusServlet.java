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
import java.sql.SQLException;

@WebServlet("/updateMovieStatusServlet")
public class UpdateMovieStatusServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://mysql-abccinema.alwaysdata.net/abccinema_host";
    private static final String DB_USER = "abccinema";
    private static final String DB_PASSWORD = "EzATWsB6Zyfpz5";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String movieIdStr = request.getParameter("movieId");
        String newStatus = request.getParameter("status");
        String newCategory = request.getParameter("category");

        try {
            int movieId = Integer.parseInt(movieIdStr);
            updateMovieStatus(movieId, newStatus , newCategory);
            response.sendRedirect("movieManagement.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update status.");
        }
    }

    private void updateMovieStatus(int movieId, String newStatus , String newCategory) throws SQLException {
        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "UPDATE movies_management SET category = ? WHERE id = ?";
            try (PreparedStatement pstmt = con.prepareStatement(query)) {
                pstmt.setString(1, newCategory);
                pstmt.setInt(2, movieId);
                pstmt.executeUpdate();
            }
        }
    }
}
