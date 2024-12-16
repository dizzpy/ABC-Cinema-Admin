<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("adminUsername") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en" class="h-full">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <title>Movie Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="${pageContext.request.contextPath}/static/js/tailwind-config.js"></script>
    <link href="${pageContext.request.contextPath}/static/css/style.css" rel="stylesheet">
</head>
<body class="bg-custom-black text-custom-white">
<div class="flex flex-col md:flex-row">
    <aside class="bg-custom-gray w-full md:w-60 min-h-screen p-5">
        <div class="mb-10">
            <a class="navbar-brand d-flex align-items-center" href="#!">
                <div class="Logo-img">
                    <jsp:include page="/static/assets/images/logo.svg"/>
                </div>
            </a>
        </div>
        <nav>
            <ul>
                <li class="mb-4">
                    <a href="movieManagement.jsp" class="text-custom-white bg-custom-black hover:text-custom-red px-4 py-2 rounded block">
                        Movie Management
                    </a>
                </li>
                <li class="mb-4">
                    <a href="userManagement.jsp" class="text-custom-white bg-custom-black hover:text-custom-red px-4 py-2 rounded block">
                        User Management
                    </a>
                </li>
                <li class="mb-4">
                    <a href="ticketManagement.jsp" class="text-custom-white bg-custom-black hover:text-custom-red px-4 py-2 rounded block">
                        Ticket Management
                    </a>
                </li>
                <li class="mb-4">
                    <a href="LogoutServlet" class="text-custom-white bg-custom-black hover:text-custom-red px-4 py-2 rounded block">
                        Logout
                    </a>
                </li>
            </ul>
        </nav>
    </aside>
    <main class="flex-1 p-6">
        <header class="flex flex-wrap justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold">Movie Management</h2>
            <form action="addMoviePage.jsp" method="get">
                <button type="submit" class="px-4 py-2 bg-custom-red text-custom-white font-normal rounded-[8px] transition-colors duration-200">
                    + Add New Movie
                </button>
            </form>
        </header>
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6">
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://mysql-abccinema.alwaysdata.net/abccinema_host", "abccinema", "EzATWsB6Zyfpz5");
                    String query = "SELECT * FROM movies_management";
                    PreparedStatement stmt = con.prepareStatement(query);
                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
                        String posterUrl = rs.getString("poster_url");
                        String title = rs.getString("title");
                        String status = rs.getString("status");
                        String category = rs.getString("category");
                        int movieId = rs.getInt("id");
            %>
            <div class="bg-custom-gray rounded-lg shadow-lg p-3 flex-shrink-0">
                <img src="<%= posterUrl %>" alt="Movie Poster" class="rounded mb-3 w-full">
                <h3 class="text-sm font-bold mb-1 text-center"><%= title %></h3>
                <p class="text-xs text-custom-textgray mb-2 text-center"><%= rs.getString("status") %> (<%= rs.getString("category") %>)</p>
                <div class="flex justify-between">
                    <form action="addMoviePage.jsp" method="get">
                        <input type="hidden" name="movieId" value="<%= movieId %>">
                        <button type="submit" class="bg-custom-black text-custom-white px-6 py-2 text-sm rounded">Edit</button>
                    </form>
                    <form method="post" action="deleteMovieServlet">
                        <input type="hidden" name="id" value="<%= movieId %>">
                        <button type="submit" class="bg-custom-red text-custom-white px-6 py-2 text-sm rounded">Delete</button>
                    </form>
                </div>
            </div>
            <%
                }
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            %>
            <p style="color: red;">Error fetching movies. Please try again later.</p>
            <%
                }
            %>
        </div>
    </main>
</div>
</body>
</html>
