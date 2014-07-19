###
|--------------------------------------------------------------------------
| Gulpfile
|--------------------------------------------------------------------------
|
| Configuration file for Gulp.
|
###

# Load the plugins automatically
gulp        = require "gulp"
run         = require("gulp-load-plugins")()
browserSync = require "browser-sync"
args        = require("yargs").argv
reload      = browserSync.reload

# Paths
paths =
  slim            : [ "factory/**/*.slim" ]
  sass            : [ "factory/**/*.scss" ]
  coffee          : [ "factory/**/*.coffee" ]

# BrowserSync
gulp.task 'browser-sync', ->
  browserSync.init null,
    notify : false
    server :
      baseDir : "./"

# Factory Tasks
gulp.task 'generate-index', ->
  gulp.src 'index.slim'
  .pipe run.plumber()
  .pipe run.slim pretty : true
  .pipe gulp.dest ""
  .pipe run.notify message : 'Index generated!'
  .pipe reload stream : true

gulp.task 'synthesize', ->
  # SLIM compiling
  gulp.src paths.slim
  .pipe run.plumber()
  .pipe run.slim pretty : true
  .pipe gulp.dest "elements/"
  .pipe run.notify message : '.slim files compiled'
  .pipe reload stream : true

  # SASS compiling
  gulp.src paths.sass
  .pipe run.plumber()
  .pipe run.rubySass style : 'compressed'
  .pipe run.autoprefixer 'last 2 version', 'safari 5', 'ie 9', 'ios 6', 'android 4'
  .pipe run.rename suffix : '.min'
  .pipe run.minifyCss()
  .pipe run.filesize()
  .pipe gulp.dest "elements/"
  .pipe run.notify message : '.scss files compiled'
  .pipe reload stream : true

  # COFFEE compiling
  gulp.src paths.coffee
  .pipe run.plumber()
  .pipe run.coffee bare : true
  .pipe run.rename suffix : '.min'
  .pipe run.minifyCss()
  .pipe run.filesize()
  .pipe gulp.dest "elements/"
  .pipe run.notify message : '.coffee files compiled'
  .pipe reload stream : true

# Pack and .zip elements
element = args.element is 'element'
gulp.task 'pack', ->

  gulp.src "elements/#{args.element}/*"
  .pipe run.zip "#{args.element}__dist.zip"
  .pipe gulp.dest "distribution/#{args.element}"

  gulp.src "factory/#{args.element}/*"
  .pipe run.zip "#{args.element}__source.zip"
  .pipe gulp.dest "distribution/#{args.element}"
  .pipe run.notify message : "#{args.element} is being packed and zipped..."

# Remove elements from distribution (if needed)
gulp.task 'trash', ->
  gulp.src "distribution/#{args.element}"
  .pipe run.rimraf()
  .pipe run.notify message : "#{args.element} has been removed from distribution folder..."

# Default
gulp.task "default", [ "browser-sync", "watch" ]

# Watch
gulp.task "watch", ['browser-sync'], () ->
  gulp.watch [
              paths.slim,
              paths.sass,
              paths.coffee
             ],              ["synthesize"]
  gulp.watch "index.*",      ["generate-index"]