<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("adminUsername") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%
    String DB_URL = "jdbc:mysql://mysql-abccinema.alwaysdata.net/abccinema_host";
    String DB_USER = "abccinema";
    String DB_PASSWORD = "EzATWsB6Zyfpz5";

    String movieId = request.getParameter("movieId");
    String currentCategory = "category";
    String title = "title";

    try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
        String query = "SELECT * FROM movies_management WHERE id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, Integer.parseInt(movieId));
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    currentCategory = rs.getString("category");
                    title = rs.getString("title");
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Movie Status</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-900 text-white font-sans min-h-screen flex items-center justify-center">
<div class="max-w-4xl w-full p-6 bg-gray-800 rounded-lg shadow-lg">
    <div class="flex items-center justify-between mb-6">
        <h1 class="text-2xl font-bold text-gray-100">Edit Movie Status</h1>
        <a href="movieManagement.jsp" class="text-gray-400 hover:text-gray-200 text-sm transition-colors">Back</a>
    </div>

    <!-- Movie Title -->
    <div class="mb-6">
        <label for="movieTitle" class="block text-sm text-gray-300 mb-2">Movie Title</label>
        <input type="text" id="movieTitle" class="w-full p-3 bg-gray-700 text-gray-100 rounded-lg" value="<%= title %>" disabled />
    </div>

    <!-- Form -->
    <form action="updateMovieStatusServlet" method="post" class="space-y-6">
        <!-- Select New Category -->
        <div>
            <label for="category" class="block text-sm text-gray-300 mb-2">Select Movie Category</label>
            <select
                    id="category"
                    name="category"
                    class="w-full p-3 bg-gray-700 text-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500 hover:shadow-md transition-shadow">
                <option value="Screening Now Home" <%= currentCategory.equals("Screening Now Home") ? "selected" : "" %>>Screening Now Home</option>
                <option value="Coming Soon Home" <%= currentCategory.equals("Coming Soon Home") ? "selected" : "" %>>Coming Soon Home</option>
                <option value="Screening Now Main" <%= currentCategory.equals("Screening Now Main") ? "selected" : "" %>>Screening Now Main</option>
                <option value="Coming Soon Main" <%= currentCategory.equals("Coming Soon Main") ? "selected" : "" %>>Coming Soon Main</option>
            </select>
        </div>

        <!-- Hidden Input -->
        <input type="hidden" name="movieId" value="<%= movieId %>">

        <!-- Action Buttons -->
        <div class="flex justify-end space-x-4">
            <a
                    href="movieManagement.jsp"
                    class="bg-gray-700 text-gray-300 px-4 py-2 rounded-lg hover:bg-gray-600 hover:shadow-md transition-shadow">
                Cancel
            </a>
            <button
                    type="submit"
                    class="bg-red-500 text-white px-4 py-2 rounded-lg hover:bg-red-600 hover:shadow-md transition-shadow">
                Update Status
            </button>
        </div>
    </form>
</div>
</body>
</html>
