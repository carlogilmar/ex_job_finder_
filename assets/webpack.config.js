const path = require('path');
const glob = require('glob');
const webpack = require('webpack');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = (env, options) => ({
  optimization: {
    minimizer: [
      new UglifyJsPlugin({ cache: true, parallel: true, sourceMap: false }),
      new OptimizeCSSAssetsPlugin({})
    ]
  },
  entry: {
     app: ['./js/app.js'].concat(glob.sync('./vendor/**/*.js')),
     job_controller: ['./js/controllers/job_controller.js'],
     suscriptor_controller: ['./js/controllers/suscriptor_controller.js'],
     updt_job_controller: ['./js/controllers/updt_job_controller.js'],
     analytics_controller: ['./js/controllers/analytics_controller.js'],
     profile_controller: ['./js/controllers/profile_controller.js'],
     application_controller: ['./js/controllers/application_controller.js']
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, '../priv/static/js')
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        }
      },
      {
        test: /\.css$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader']
      },
      {
        test: /\.(woff(2)?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
        use: [{
          loader: 'file-loader',
          options: {
            name: '[name].[ext]',
            outputPath: '../fonts'
          }
        }]
      }
    ]
  },
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js'
    }
  },
  plugins: [
    new MiniCssExtractPlugin({ filename: '../css/[name].css' }),
    new CopyWebpackPlugin([{ from: 'static/', to: '../' }])
  ]
});
