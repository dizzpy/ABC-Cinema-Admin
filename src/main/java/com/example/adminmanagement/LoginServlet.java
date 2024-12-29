package com.example.adminmanagement;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Database Connection
            Connection con = DriverManager.getConnection("jdbc:mysql://mysql-abccinema.alwaysdata.net/abccinema_host", "abccinema", "EzATWsB6Zyfpz5");

            // SQL Query
            String query = "SELECT * FROM admin_auth WHERE username = ? AND password = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Login successful
                HttpSession session = request.getSession();
                session.setAttribute("adminUsername", username);
                response.sendRedirect("movieManagement.jsp");
            } else {
                // Invalid login
                PrintWriter out = response.getWriter();
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Invalid Username or Password!');");
                out.println("location='login.jsp';");
                out.println("</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database Connection Error!");
        }
    }
}

