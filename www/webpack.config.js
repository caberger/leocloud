const { resolve } = require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
const CopyWebpackPlugin = require("copy-webpack-plugin")
const _ = require("lodash")

const webpack = require('webpack')
const packageJson = require('./package.json')

const options = env => {
    const isDebug =  env.debug === "true"
    return {
        isDebug,
        ENV: isDebug ? 'development' : 'production',
        OUTPUT_PATH: isDebug ? resolve(__dirname, ".") : resolve(__dirname, "target"),
        publicPath: isDebug ? "auto" : ".",
        baseHref: env.base ? env.base : "/"
    }
}
const environment = opts => ({
    NODE_ENV: opts.ENV,
    appVersion: packageJson.version
})
const entryPoints = [
    { chunk: "main", entry: "index.html", src: "index.ts" },
    { chunk: "app", entry: "app.html", src: "view/app.js" }
]
const entry = {}
entryPoints.forEach(ep => {
    entry[ep.chunk] = "./src/" + ep.src
})
const htmlWebpackPlugins = opts => {
    return entryPoints.map(ep =>
        new HtmlWebpackPlugin({
            compile: true,
            chunks: [ep.chunk],
            template: `${resolve("./" + ep.entry)}`,
            filename: ep.entry,
            publicPath: opts.publicPath
        })
    )}
const plugins = opts => {
    const env = environment(opts)
    console.log("environment=", env)  
    return [
        ...htmlWebpackPlugins(opts),
        new MiniCssExtractPlugin({
            filename: '[name]-[contenthash].css',
            chunkFilename: '/[id].css',
        }),
        new CopyWebpackPlugin({
            patterns: [
                {from: "images", to: "images"},
            ]
        }),        
        //new CleanWebpackPlugin({ verbose: true }),
        new webpack.EnvironmentPlugin(env)        
]}
module.exports = env => {
    const opts = options(env)
    console.log("options: ", opts)
    return {
        mode: opts.ENV,
        entry,
        plugins: plugins(opts),
        output: {
            path: opts.OUTPUT_PATH,
            filename: "[name]-[contenthash].js",
            chunkFilename: '[name]-[contenthash].bundle.js',
            publicPath: opts.publicPath
        },
        module: {
            rules: [
                {
                    test: /\.html$/,
                    use: [
                        {
                            loader: "html-loader",
                            options: {
                                preprocessor: preprocessor(opts)
                            }
                        }
                    ]
                },
                {
                    test: /\.scss$/i,
                    use: [
                        MiniCssExtractPlugin.loader,
                        "css-loader",
                        "sass-loader"
                    ]
                },
                {
                    test: /\.css$/i,
                    use: [
                        "style-loader",
                        {
                            loader: "css-loader",
                            options: {
                                modules: true,
                                sourceMap: true,
                                importLoader: 2
                            }
                        },
                        "sass-loader"
                    ]
                },
                {
                    test: /\.tsx?$/,
                    use: 'ts-loader',
                    exclude: /node_modules/
                },
                {
                    test: /\.js$/,
                    exclude: /(node_modules)/,
                    use: {
                        loader: 'babel-loader',
                        options: {
                            presets: [[
                                '@babel/preset-env',
                                {
                                    targets: {
                                        browsers: [
                                            // Best practice: https://github.com/babel/babel/issues/7789
                                            '>=1%',
                                            'not ie 11',
                                            'not op_mini all'
                                        ]
                                    },
                                    debug: false
                                }
                            ]],
                            plugins: [
                                ['@babel/plugin-syntax-object-rest-spread', { useBuiltIns: true }],
                                "@babel/plugin-proposal-private-methods",
                                "@babel/plugin-proposal-class-properties"
                            ]
                        }
                    }
                },
                {
                    test: /\.(png|jpg|gif)$/i,
                    use: [
                        {
                            loader: 'url-loader',
                            options: {
                                limit: 8192,
                                name: "img/[name]_[hash].[ext]"
                            }
                        }
                    ]
                },
                {
                    test: /\.(woff(2)?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
                    use: [
                        {
                            loader: 'file-loader',
                            options: {
                                name: '[name].[ext]',
                                outputPath: 'fonts/'
                            }
                        }
                    ]
                },
            ]
        },
        resolve: {
            extensions: ['.tsx', '.ts', '.js'],
            alias: {
                Rest: resolve(__dirname, 'src/rest/'),
                Lib: resolve(__dirname, 'src/lib/'),
                Model: resolve(__dirname, 'src/model/'),
                Styles: resolve(__dirname, 'src/styles/')
            }
        },
        devtool: 'cheap-source-map',
        devServer: {
            compress: false,
            hot: true,
            port: 4000,
            host: '0.0.0.0',

            historyApiFallback: {
                verbose: true
            },
            proxy: {
                '/api/': {
                    target: 'http://localhost:8080/',
                    ws: true
                }
            }
        }
    }
}

function preprocessor(options) {
    return (content, loaderContext) => {
        let result = content
        try {
            const compiled = _.template(content)
            result = compiled({options})
        } catch(error) {
            loaderContext.emitError(error)
        }
        return result
    }
}