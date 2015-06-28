'use strict'

gulp         = require 'gulp'
wiredep      = require('wiredep').stream
$            = require('gulp-load-plugins')()
browserSync  = require 'browser-sync'
reload       = browserSync.reload
spritesmith  = require 'gulp.spritesmith'

gulp.task 'sprite', ->
    spriteData = gulp.src('img/sprites/*.png').pipe spritesmith
        imgName:      'sprites.png'
        padding:      15
        algorithm:    'binary-tree'
        cssName:      'sprite.styl'
        cssFormat:    'stylus'
    spriteData.img.pipe gulp.dest 'img'
    spriteData.css.pipe gulp.dest 'stylus/core'

gulp.task 'coffee', ->
  gulp.src('coffee/main.coffee')
    .pipe $.plumber()
    .pipe $.coffee bare: on
    .pipe gulp.dest 'js'

gulp.task 'wiredep', ->
  gulp.src 'jade/layouts/layout.jade'
    .pipe wiredep()
    .pipe gulp.dest 'jade/layouts'

  gulp.src 'stylus/all.styl'
    .pipe wiredep()
    .pipe gulp.dest 'stylus'

gulp.task 'stylus', ->
  gulp.src 'stylus/all.styl'
    .pipe $.plumber()
    .pipe $.sourcemaps.init()
    .pipe $.stylus 'include css': on
    .pipe $.autoprefixer
      browsers: [ 'last 2 versions' ]
      cascade: on
    .pipe $.sourcemaps.write()
    .pipe gulp.dest 'css'

gulp.task 'jade', ->
  gulp.src 'jade/*.jade'
    .pipe $.jade pretty: no
    .pipe gulp.dest ''

gulp.task 'default', ['stylus', 'coffee', 'jade'], ->
  browserSync
    server:
      baseDir: ['']

  gulp.watch [
    '*.html'
    'js/*.js'
    'css/*.css'
  ]
  .on 'change', reload

  gulp.watch 'stylus/**/*.styl',  ['stylus']
  gulp.watch 'coffee/*.coffee',   ['coffee']
  gulp.watch 'jade/**/*.jade',    ['jade']
  gulp.watch 'bower.json',            ['wiredep']
