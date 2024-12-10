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

    <title>Movie Management</title>

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
            <h2 class="text-2xl font-semibold">Movie Management</h2>
            <form action="addMoviePage.jsp" method="get" style="display: inline;">
                <button type="submit" class="px-4 py-2 bg-custom-red text-custom-white font-normal rounded-[8px] transition-colors duration-200">
                    + Add New Movie
                </button>
            </form>
        </header>

        <!-- Movie Cards Container -->
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6">
            <!-- First Card -->
            <div class="bg-custom-gray rounded-lg shadow-lg p-3 flex-shrink-0">
                <img src="https://via.placeholder.com/100" alt="Movie Poster" class="rounded mb-3 w-full">
                <h3 class="text-sm font-bold mb-1 text-center">The Wild Robot</h3>
                <p class="text-xs text-custom-textgray mb-2 text-center">Now Showing</p>
                <div class="flex justify-between ">
                    <button class="bg-custom-black text-custom-white px-6 py-2 text-sm rounded">Edit</button>
                    <button class="bg-custom-red text-custom-white px-6 py-2 text-sm rounded">Delete</button>
                </div>
            </div>

            <!-- Second Card -->
            <div class="bg-custom-gray rounded-lg shadow-lg p-3 flex-shrink-0">
                <img src="https://via.placeholder.com/100" alt="Movie Poster" class="rounded mb-3 w-full">
                <h3 class="text-sm font-bold mb-1 text-center">Avatar</h3>
                <p class="text-xs text-custom-textgray mb-2 text-center">Now Showing</p>
                <div class="flex justify-between">
                    <button class="bg-custom-black text-custom-white px-6 py-2 text-sm rounded">Edit</button>
                    <button class="bg-custom-red text-custom-white px-6 py-2 text-sm rounded">Delete</button>
                </div>
            </div>

            <!-- Third Card -->
            <div class="bg-custom-gray rounded-lg shadow-lg p-3 flex-shrink-0">
                <img src="https://via.placeholder.com/100" alt="Movie Poster" class="rounded mb-3 w-full">
                <h3 class="text-sm font-bold mb-1 text-center">Civil War</h3>
                <p class="text-xs text-custom-textgray mb-2 text-center">Now Showing</p>
                <div class="flex justify-between">
                    <button class="bg-custom-black text-custom-white px-6 py-2 text-sm rounded">Edit</button>
                    <button class="bg-custom-red text-custom-white px-6 py-2 text-sm rounded">Delete</button>
                </div>
            </div>

            <!-- Fourth Card -->
            <div class="bg-custom-gray rounded-lg shadow-lg p-3 flex-shrink-0">
                <img src="https://via.placeholder.com/100" alt="Movie Poster" class="rounded mb-3 w-full">
                <h3 class="text-sm font-bold mb-1 text-center">The Batman</h3>
                <p class="text-xs text-custom-textgray mb-2 text-center">Now Showing</p>
                <div class="flex justify-between">
                    <button class="bg-custom-black text-custom-white px-6 py-2 text-sm rounded">Edit</button>
                    <button class="bg-custom-red text-custom-white px-6 py-2 text-sm rounded">Delete</button>
                </div>
            </div>

            <!-- Fifth Card -->
            <div class="bg-custom-gray rounded-lg shadow-lg p-3 flex-shrink-0">
                <img src="https://via.placeholder.com/100" alt="Movie Poster" class="rounded mb-3 w-full">
                <h3 class="text-sm font-bold mb-1 text-center">Arcane</h3>
                <p class="text-xs text-custom-textgray mb-2 text-center">Now Showing</p>
                <div class="flex justify-between">
                    <button class="bg-custom-black text-custom-white px-6 py-2 text-sm rounded">Edit</button>
                    <button class="bg-custom-red text-custom-white px-6 py-2 text-sm rounded">Delete</button>
                </div>
            </div>
        </div>


    </main>

</div>
</body>
</html>
