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

    <title>Login | Admin</title>

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>

    <%-- Tailwind config file --%>
    <script src="${pageContext.request.contextPath}/static/js/tailwind-config.js"></script>
    <link href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body class="bg-custom-black min-h-screen flex flex-col items-center justify-center">
<div class="w-[350px] text-center">
    <p class="text-[20px] text-custom-white mb-6">Login as Admin</p>

    <%--  Email Inputbox  --%>
    <input
            type="email"
            id="email"
            name="email"
            placeholder="sampleemail@abc.com"
            class="w-full bg-custom-black text-custom-white placeholder:text-custom-textgray border border-custom-textgray focus:outline-none focus:ring-1 focus:ring-custom-gray rounded-md px-5 py-3"
    />

    <%--  Password Inputbox  --%>
    <input
            type="password"
            id="password"
            name="email"
            placeholder="***********"
            class="mt-5 w-full bg-custom-black text-custom-white placeholder:text-custom-textgray border border-custom-textgray focus:outline-none focus:ring-1 focus:ring-custom-gray rounded-md px-5 py-3"
    />


    <%--  Create Account Button  --%>
    <button class="w-full bg-custom-red text-custom-white rounded-md px-5 py-3 mt-10">
        Login to Account
    </button>

</div>
</body>

</html>
