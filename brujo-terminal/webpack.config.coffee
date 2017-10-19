path = require 'path'
# webpack = require 'webpack'
# ExtractTextPlugin = require 'extract-text-webpack-plugin'

module.exports =
    entry: "./src/entry.coffee"
    output:
        path: path.resolve(__dirname, "public", "js")
        filename: "app_development.js"
        libraryTarget: "umd"
    module:
        rules: [
            {
                test: /\.coffee?/
                use: [ 'coffee-loader' ]
            },
            {
                test: /\.(png)$/
                use: [ 'url-loader' ]
            }
        ]
#,
    #         {
    #             test: /\.css$/
    #             use: ExtractTextPlugin.extract
    #                 fallback: "style-loader"
    #                 use:
    #                     loader: "css-loader"
    #                     options:
    #                         sourceMap: true
    #                 publicPath: "./public"
    #         }
    #     ]
    # devtool: "source-map"
    # plugins: [
    #     new ExtractTextPlugin
    #         filename: "css/[name].css?[hash]-[chunkhash]-[contenthash]-[name]"
    #         disable: false
    #         allChunks: true
    #     new webpack.optimize.CommonsChunkPlugin
    #         name: "c"
    #         filename: "c.js"
    # ]
