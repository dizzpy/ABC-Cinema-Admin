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

@WebServlet("/publishMovieServlet")
public class PublishMovieServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve movie details from the form
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String posterUrl = request.getParameter("poster_url");
        String category = request.getParameter("category");
        String genres = request.getParameter("genres");
        String pg = request.getParameter("parental_guidance");
        String imdbRating = request.getParameter("imdb_rating"); // Get IMDb rating
        String runtime = request.getParameter("runtime"); // Get runtime

        // Insert movie data into the database
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://mysql-abccinema.alwaysdata.net/abccinema_host", "abccinema", "EzATWsB6Zyfpz5");

            // Update the query to include imdb_rating and runtime
            String query = "INSERT INTO movies_management (title, description, poster_url, category, genres, pg, imdb_rating, runtime, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Published')";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, title);
            pst.setString(2, description);
            pst.setString(3, posterUrl);
            pst.setString(4, category);
            pst.setString(5, genres);
            pst.setString(6, pg);
            pst.setString(7, imdbRating);  // Set IMDb rating
            pst.setString(8, runtime);     // Set runtime

            pst.executeUpdate();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("movieManagement.jsp");
    }
}
