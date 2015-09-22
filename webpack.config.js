module.exports = {
  entry: {
    application: "./app/client/javascripts/application.js",
  },
  output: {
    path: __dirname + '/app/client/dist',
    filename: "[name].js",
    publicPath: "/a/"
  },
  module: {
    loaders: [
      {
        // "test" is commonly used to match the file extension
        test: /\.jsx?$/,

        // // "include" is commonly used to match the directories
        // include: [
        //   path.resolve(__dirname, "app/src"),
        //   path.resolve(__dirname, "app/test")
        // ],

        // "exclude" should to used to exclude exceptions
        // try to prefer "include" when possible
        exclude: /node_modules/,

        // the "loader"
        loader: "babel-loader"
      },
      {
        test: /\.scss$/,
        loader: 'style!css!sass'
      },
      { 
        test: /\.(eot|woff2?|ttf|svg)(\?.*)?$/,
        loader: "file" }
    ]
  }
};