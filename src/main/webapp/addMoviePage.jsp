<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.net.*, java.io.*, org.json.*, java.util.*" %>
<%
    String movieTitle = request.getParameter("movieTitle");
    String TMDB_API_KEY = "0453add907cb3ae092654a9edc87e895";
    String TMDB_BASE_URL = "https://api.themoviedb.org/3";

    JSONObject movieData = null;
    String movieGenres = "";
    String parentalGuidance = "Not Available";
    String imdbRating = "Not Available";
    String runtime = "Not Available";
    Map<Integer, String> genreMap = new HashMap<>();

    // Fetch genre list from TMDB API
    try {
        String genreUrl = TMDB_BASE_URL + "/genre/movie/list?api_key=" + TMDB_API_KEY;
        URL url = new URL(genreUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String apiResponse = in.lines().reduce("", (acc, line) -> acc + line);
        in.close();

        JSONObject genreResponse = new JSONObject(apiResponse);
        JSONArray genresArray = genreResponse.getJSONArray("genres");
        for (int i = 0; i < genresArray.length(); i++) {
            JSONObject genreObject = genresArray.getJSONObject(i);
            int genreId = genreObject.getInt("id");
            String genreName = genreObject.getString("name");
            genreMap.put(genreId, genreName);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // If a movie title is provided, search for the movie
    if (movieTitle != null && !movieTitle.isEmpty()) {
        try {
            String apiUrl = TMDB_BASE_URL + "/search/movie?api_key=" + TMDB_API_KEY + "&query=" + URLEncoder.encode(movieTitle, "UTF-8");
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String apiResponse = in.lines().reduce("", (acc, line) -> acc + line);
            in.close();

            JSONObject jsonResponse = new JSONObject(apiResponse);
            if (jsonResponse.getJSONArray("results").length() > 0) {
                movieData = jsonResponse.getJSONArray("results").getJSONObject(0);

                // Get genres from movie data and map to names
                JSONArray genresArray = movieData.optJSONArray("genre_ids");
                if (genresArray != null) {
                    StringBuilder genres = new StringBuilder();
                    for (int i = 0; i < genresArray.length(); i++) {
                        int genreId = genresArray.getInt(i);
                        if (genreMap.containsKey(genreId)) {
                            if (i > 0) genres.append(", ");
                            genres.append(genreMap.get(genreId));
                        }
                    }
                    movieGenres = genres.toString();
                }

                // Fetch detailed movie information
                int movieId = movieData.getInt("id");
                String movieDetailsUrl = TMDB_BASE_URL + "/movie/" + movieId + "?api_key=" + TMDB_API_KEY;
                url = new URL(movieDetailsUrl);
                conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                apiResponse = in.lines().reduce("", (acc, line) -> acc + line);
                in.close();

                JSONObject movieDetails = new JSONObject(apiResponse);
                runtime = movieDetails.optInt("runtime", 0) > 0 ? movieDetails.optInt("runtime") + " minutes" : "Not Available";
                imdbRating = movieDetails.has("vote_average") && !movieDetails.isNull("vote_average")
                        ? String.format("%.1f", movieDetails.getFloat("vote_average"))
                        : "Not Available";


                // Fetch parental guidance information
                String releaseDatesUrl = TMDB_BASE_URL + "/movie/" + movieId + "/release_dates?api_key=" + TMDB_API_KEY;
                url = new URL(releaseDatesUrl);
                conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                apiResponse = in.lines().reduce("", (acc, line) -> acc + line);
                in.close();

                JSONObject releaseDatesResponse = new JSONObject(apiResponse);
                JSONArray results = releaseDatesResponse.optJSONArray("results");
                if (results != null) {
                    for (int i = 0; i < results.length(); i++) {
                        JSONObject result = results.getJSONObject(i);
                        if ("US".equals(result.optString("iso_3166_1"))) { // Look for US certification
                            JSONArray releaseDates = result.getJSONArray("release_dates");
                            for (int j = 0; j < releaseDates.length(); j++) {
                                JSONObject releaseDate = releaseDates.getJSONObject(j);
                                parentalGuidance = releaseDate.optString("certification", "Not Available").trim();
                                if (!parentalGuidance.isEmpty()) break;
                            }
                        }
                        if (!parentalGuidance.equals("Not Available")) break;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>


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
        <form method="get" action="addMoviePage.jsp">
            <label for="movie-title" class="block  text-base mb-2">
                Movie Title <span class="text-red-500">*</span>
            </label>
            <div class="flex">
                <input id="movie-title" type="text" name="movieTitle" placeholder="Venom: Let There Be Carnage"
                       class="bg-custom-gray w-full p-3 text-custom-white rounded-lg focus:ring-custom-red focus:border-custom-red mr-10 value="<%= movieTitle != null ? movieTitle : "" %>">
                <button type="submit"
                        class="px-4 py-2 bg-custom-red text-custom-white font-normal rounded-[8px] transition-colors duration-200">
                    Search
                </button>
                <button type="reset" onclick="window.location.href='addMoviePage.jsp';"
                        class="px-4 py-2 bg-custom-white text-custom-black font-normal rounded-[8px] transition-colors duration-200 ml-5">
                    Discard
                </button>
            </div>
        </form>
    </div>

    <% if (movieData != null) { %>
    <!-- Movie Preview Section -->
    <div class="mx-auto container mt-10 max-w-5xl">
        <div class="flex flex-col md:flex-row items-start justify-center space-x-0 md:space-x-16">

            <!-- Movie Poster -->
            <div class="w-[268.53px] h-[355px] mx-auto md:mx-0">
                <img src="https://image.tmdb.org/t/p/w500<%= movieData.getString("poster_path") %>"
                     alt="Poster"
                     class="rounded w-full h-full object-cover">
            </div>

            <!-- Movie Details -->
            <div class="w-full md:w-2/3 md:mt-0 mt-10">
                <!-- Movie Title -->
                <p class="text-[36px] md:text-[42px] text-custom-white font-bold">
                    <%= movieData.getString("title") %>
                </p>

                <!-- Runtime, Category, Ratings -->
                <div class="flex flex-row items-center space-x-4 mt-4">
                    <!-- Run Time -->
                    <div class="flex flex-row items-center">
                        <img src="${pageContext.request.contextPath}/static/assets/icons/clock-white.svg"
                             alt="Run Time" class="h-5 w-5">
                        <p class="text-sm md:text-base text-custom-textgray ml-1 font-normal"><%= runtime %>
                        </p>
                    </div>

                    <!-- Separator -->
                    <div class="h-2 w-2 rounded-full bg-custom-white"></div>

                    <!-- Category -->
                    <div class="flex flex-row items-center">
                        <p class="text-sm md:text-base text-custom-textgray font-normal"><%= parentalGuidance %>
                        </p>
                    </div>

                    <!-- Separator -->
                    <div class="h-2 w-2 rounded-full bg-custom-white"></div>

                    <!-- IMDb Ratings -->
                    <div class="flex flex-row items-center space-x-2">
                        <img src="${pageContext.request.contextPath}/static/assets/icons/imdb-logo.png"
                             alt="IMDb Logo" class="h-5 w-auto">
                        <p class="text-sm md:text-base text-custom-textgray font-normal"><%= imdbRating %>
                        </p>
                    </div>
                </div>

                <%--  <p class="text-xl text-custom-white mt-4"></p>  --%>

                <!-- Movie Description -->
                <p class="text-sm md:text-base text-custom-textgray mt-4">
                    <%= movieData.getString("overview") %>
                </p>

                <p class="text-xl text-custom-white mt-5">Category</p>

                <p class="text-sm md:text-base text-custom-textgray mt-2">
                    <%= movieGenres %>
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
        <form method="post" action="publishMovieServlet">
            <input type="hidden" name="title" value="<%= movieData.getString("title") %>">
            <input type="hidden" name="description" value="<%= movieData.getString("overview") %>">
            <input type="hidden" name="genres" value="<%= movieGenres %>">
            <input type="hidden" name="poster_url"
                   value="https://image.tmdb.org/t/p/w500<%= movieData.getString("poster_path") %>">
            <input type="hidden" name="imdb_rating" value="<%= imdbRating %>">
            <input type="hidden" name="runtime" value="<%= runtime %>">
            <input type="hidden" name="parental_guidance" value="<%= parentalGuidance %>">


            <label for="category" class="block text-base font-medium mb-2">
                Select Movie Category <span class="text-custom-red">*</span>
            </label>
            <select name="category" id="category" required style="background-color: #282727;"
                    class="w-5/12 p-3  text-custom-white rounded-lg focus:ring-custom-red focus:border-custom-red">
                <option>Screening Now Home</option>
                <option>Coming Soon Home</option>
                <option>Screening Now Main</option>
                <option>Coming Soon Main</option>
            </select>
            <!-- Publish Button -->
            <div class="flex justify-end w-full max-w-5xl">

                <button type="submit"
                        class="bg-custom-red text-custom-white px-6 py-3 rounded-lg  flex items-center gap-2">
                    Publish Movie
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"
                         class="w-5 h-5">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M17 8l4 4m0 0l-4 4m4-4H3"></path>
                    </svg>
                </button>

            </div>
        </form>

    </div>


    <% } %>


</main>
</body>
</html>
