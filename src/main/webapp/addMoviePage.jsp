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
<body class="bg-custom-black text-custom-white min-h-screen flex flex-col">

<!-- Back Button -->
<header class="flex items-center p-6">
    <button class="bg-custom-gray text-custom-white p-2 rounded-md"
            onclick="window.location.href='movieManagement.jsp'">
        <span class="sr-only">Go Back</span>
        <!-- Icon for Back Button -->
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" class="w-6 h-6">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
        </svg>
    </button>
    <h1 class="text-2xl font-bold ml-20">Add Your Movie Details</h1>
</header>

<!-- Main Content -->
<main class="flex-grow flex flex-col justify-center items-center p-6 ">
    <!-- Movie Title -->
    <div class="mb-6 w-full max-w-5xl">
        <label for="movie-title" class="block  text-base mb-2">
            Movie Title <span class="text-red-500">*</span>
        </label>
        <div class="flex">
            <input id="movie-title" type="text" placeholder="Venom: Let There Be Carnage"
                   class="bg-custom-gray w-full p-3 text-custom-white rounded-lg focus:ring-custom-red focus:border-custom-red mr-10">
            <button class="px-4 py-2 bg-custom-red text-custom-white font-normal rounded-[8px] transition-colors duration-200">
                Search
            </button>
            <button class="px-4 py-2 bg-custom-white text-custom-black font-normal rounded-[8px] transition-colors duration-200 ml-5">
                Discard
            </button>
        </div>
    </div>

    <!-- Movie Preview Section -->
    <div class="mx-auto container mt-10 max-w-5xl">
        <div class="flex flex-col md:flex-row items-start justify-center space-x-0 md:space-x-16">

            <!-- Movie Poster -->
            <div class="w-[268.53px] h-[355px] mx-auto md:mx-0">
                <img src="https://image.tmdb.org/t/p/w1280/1MJNcPZy46hIy2CmSqOeru0yr5C.jpg"
                     alt="Venom"
                     class="rounded w-full h-full object-cover">
            </div>

            <!-- Movie Details -->
            <div class="w-full md:w-2/3 md:mt-0 mt-10">
                <!-- Movie Title -->
                <p class="text-[36px] md:text-[42px] text-custom-white font-bold">
                    Venom: Let There Be Carnage
                </p>

                <!-- Runtime, Category, Ratings -->
                <div class="flex flex-row items-center space-x-4 mt-4">
                    <!-- Run Time -->
                    <div class="flex flex-row items-center">
                        <img src="${pageContext.request.contextPath}/static/assets/icons/clock-white.svg"
                             alt="Run Time" class="h-5 w-5">
                        <p class="text-sm md:text-base text-custom-textgray ml-1 font-normal">1h 37m</p>
                    </div>

                    <!-- Separator -->
                    <div class="h-2 w-2 rounded-full bg-custom-white"></div>

                    <!-- Category -->
                    <div class="flex flex-row items-center">
                        <p class="text-sm md:text-base text-custom-textgray font-normal">PG-13</p>
                    </div>

                    <!-- Separator -->
                    <div class="h-2 w-2 rounded-full bg-custom-white"></div>

                    <!-- IMDb Ratings -->
                    <div class="flex flex-row items-center space-x-2">
                        <img src="${pageContext.request.contextPath}/static/assets/icons/imdb-logo.png"
                             alt="IMDb Logo" class="h-5 w-auto">
                        <p class="text-sm md:text-base text-custom-textgray font-normal">8.2/10</p>
                    </div>
                </div>

                <p class="text-xl text-custom-white mt-4">Overview</p>

                <!-- Movie Description -->
                <p class="text-sm md:text-base text-custom-textgray mt-4">
                    Eddie Brock attempts to reignite his career by
                    interviewing serial killer Cletus Kasady, who becomes the host of the symbiote Carnage and
                    escapes prison after a failed execution.
                </p>

                <p class="text-xl text-custom-white mt-5">Category</p>

                <p class="text-sm md:text-base text-custom-textgray mt-2">
                    Action, Adventure, Sci-Fi
                </p>

                <!-- Buttons Section -->
                <div class="flex flex-row space-x-4 mt-5">
                    <!-- Watch Trailer Button -->
                    <a href="#"
                       class="flex flex-row items-center px-4 py-2 bg-custom-white text-custom-black border border-custom-black hover:bg-gray-50 font-medium rounded-lg transition-colors duration-200 decoration-none">
                        <span class="text-base">Watch Trailer</span>
                        <img src="${pageContext.request.contextPath}/static/assets/icons/play.svg"
                             alt="play" class="h-4 w-4 ml-2">
                    </a>

                </div>
            </div>
        </div>
    </div>

    <!-- Movie Category -->
    <div class="mb-6 mt-12 w-full max-w-5xl">
        <label for="movie-category" class="block text-base font-medium mb-2">
            Select Movie Category <span class="text-custom-red">*</span>
        </label>
        <select id="movie-category" style="background-color: #282727;"
                class="w-5/12 p-3  text-custom-white rounded-lg focus:ring-custom-red focus:border-custom-red">
            <option value="screen-now-home">Screening Now Home</option>
            <option value="release-soon-home">Release Soon Home</option>
            <option value="screen-now-main">Screening Now Main</option>
            <option value="release-soon-main">Release Soon Main</option>
        </select>
    </div>

    <!-- Publish Button -->
    <div class="flex justify-end w-full max-w-5xl">
        <button class="bg-custom-red text-custom-white px-6 py-3 rounded-lg  flex items-center gap-2">
            Publish Movie
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"
                 class="w-5 h-5">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M17 8l4 4m0 0l-4 4m4-4H3"></path>
            </svg>
        </button>
    </div>


</main>
</body>
</html>
