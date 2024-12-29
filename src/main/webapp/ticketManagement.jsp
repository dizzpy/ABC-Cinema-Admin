<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap"
          rel="stylesheet">
    <title>User Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="${pageContext.request.contextPath}/static/js/tailwind-config.js"></script>


</head>
<body class="bg-custom-black text-custom-white">
<div class="flex flex-col md:flex-row">
    <aside class="bg-custom-gray w-full md:w-60 min-h-screen p-5">
        <div class="mb-10">
            <a class="navbar-brand d-flex align-items-center" href="#!">
                <jsp:include page="/static/assets/images/logo.svg"/>
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
                    <a href="reviewManagement.jsp" class="text-custom-white bg-custom-black hover:text-custom-red px-4 py-2 rounded block">
                        Review Management
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
            <h2 class="text-2xl font-semibold">Ticket Management</h2>
        </header>

        <section class="user-details mb-8">
            <h3 class="text-xl font-semibold mb-4">Booking Details</h3>
            <table id="userTable" class="w-full border-collapse mb-5">
                <thead>
                <tr class="bg-custom-gray">
                    <th class="border border-[#444] p-1 text-center ">Order ID</th>
                    <th class="border border-[#444] p-1 text-center ">User ID</th>
                    <th class="border border-[#444] p-1 text-center">Movie ID</th>
                    <th class="border border-[#444] p-1 text-center">Seat NO</th>
                    <th class="border border-[#444] p-1 text-center ">Booking Date</th>
                    <th class="border border-[#444] p-1 text-center">Total Price</th>
                    <th class="border border-[#444] p-1 text-center">Show Date</th>
                    <th class="border border-[#444] p-2 text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <% Connection con = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://mysql-abccinema.alwaysdata.net/abccinema_host", "abccinema", "EzATWsB6Zyfpz5");
                        stmt = con.createStatement();
                        rs = stmt.executeQuery("SELECT * FROM orders");
                        while (rs.next()) {
                %>
                <tr class="hover:bg-custom-gray/50">
                    <td class="border border-[#444] p-1 text-center"><%= rs.getInt("order_id") %></td>
                    <td class="border border-[#444] p-1 text-center"><%= rs.getInt("user_id") %></td>
                    <td class="border border-[#444] p-1 text-center"><%= rs.getInt("movie_id") %></td>
                    <td class="border border-[#444] p-1 text-center"><%= rs.getString("seat_numbers") %></td>
                    <td class="border border-[#444] p-1 text-center"><%= rs.getTimestamp("booking_date") %></td>
                    <td class="border border-[#444] p-1 text-center"><%= rs.getInt("total_price") %></td>
                    <td class="border border-[#444] p-1 text-center"><%= rs.getDate("show_date") %></td>
                    <td class="border border-[#444] p-1 text-center">
                        <button onclick="confirmDeleteTicket(<%= rs.getInt("order_id") %>)" class="bg-red-600 text-white px-3 py-1 rounded hover:bg-red-700">Delete</button>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (con != null) con.close();
                    }
                %>
                </tbody>
            </table>
            <div class="flex space-x-4">
                <button onclick="exportTableToCSV('user-details.csv')" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">Download CSV</button>
                <button onclick="generatePDF()" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">Download PDF</button>
            </div>


        </section>
    </main>
</div>

<script src="${pageContext.request.contextPath}/js/user-management.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/user-management.js"></script>
<script src="${pageContext.request.contextPath}/static/js/ticket-management.js"></script>
</body>
</html>