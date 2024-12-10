<!DOCTYPE html>
<html lang="en" class="h-full">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- Add Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap"
        rel="stylesheet">

  <title>Add Movie Page</title>

  <!-- Tailwind CSS CDN -->
  <script src="https://cdn.tailwindcss.com"></script>

  <%-- Tailwind config file --%>
  <script src="${pageContext.request.contextPath}/static/js/tailwind-config.js"></script>
  <link href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body class="bg-custom-black text-custom-white">

<!-- Sidebar and Main Content -->
<div class="flex flex-col md:flex-row">
  <!-- Sidebar -->
  <aside class=" bg-custom-gray w-full md:w-60 min-h-screen p-5">
    <div class="mb-10">
      <a class="navbar-brand d-flex align-items-center" href="#!">
        <div class="Logo-img">
          <a href="#" class="navbar-brand">
            <!-- Include the logo using JSP -->
            <jsp:include page="/static/assets/images/logo.svg"/>
          </a>
        </div>
      </a>
    </div>
    <!-- Navigation Bar -->
    <nav>
      <ul>
        <!-- Movie Management Link -->
        <li class="mb-4">
          <a href="movieManagement.jsp"
             class="text-custom-white bg-custom-black hover:text-custom-red px-4 py-2 rounded block">
            Movie Management
          </a>
        </li>

        <!-- User Management Link -->
        <li class="mb-4">
          <a href="userManagement.jsp"
             class="text-custom-white bg-custom-black hover:text-custom-red px-4 py-2 rounded block">
            User Management
          </a>
        </li>

        <!-- Ticket Management Link -->
        <li class="mb-4">
          <a href="ticketManagement.jsp"
             class="text-custom-white bg-custom-black hover:text-custom-red px-4 py-2 rounded block">
            Ticket Management
          </a>
        </li>

        <!-- Logout Link -->
        <li class="mb-4">
          <a href="#" class="text-custom-white bg-custom-black hover:text-custom-red px-4 py-2 rounded block">
            Logout
          </a>
        </li>
      </ul>
    </nav>
  </aside>

  <!-- Main Content -->
  <main class="flex-1 p-6">
    <!-- Header -->
    <header class="flex flex-wrap justify-between items-center mb-6">
      <h2 class="text-2xl font-semibold">User Management</h2>
      </header>
  </main>
</div>
</body>
</html>
