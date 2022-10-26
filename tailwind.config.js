module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
    "./node_modules/flowbite/**/*.js",
  ],
  theme: {
    extend: {
      fontFamily: {
        helvetica: ["Helvetica Now Display", "sans-serif"],
      },
    },
  },
  plugins: [require("flowbite/plugin")],
};
