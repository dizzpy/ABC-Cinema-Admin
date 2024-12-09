tailwind.config = {
    theme: {
        fontFamily: {
            sans: ['Inter', 'system-ui', 'sans-serif'],
        },
        extend: {
            colors: {
                custom: {
                    black: '#171717',
                    red: '#E64C45',
                    white: '#FFFFFF',
                    gray: '#282727',
                    textgray: '#B1B1B1'
                }
            },
        },
        plugins: {
            tailwindcss: {},
            autoprefixer: {},
        },
    }
}