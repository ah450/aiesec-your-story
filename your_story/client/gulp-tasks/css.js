// Compiles sass
// Outputs main.css as topfile in build and dist folders
var gulp = require('gulp');
var concatCss = require('gulp-concat-css');
var sass = require('gulp-sass');
var minifyCss = require('gulp-minify-css');
var postcss = require('gulp-postcss');
var autoprefixer = require('autoprefixer-core');
var order = require('gulp-order');
var urlAdjuster = require('gulp-css-url-adjuster');

gulp.task('css-min', ['css'], function() {
  return gulp.src('build/main.css')
    .pipe(minifyCss({
      keepSpecialComments: 0,
      rebase: false
    }))
    .pipe(gulp.dest('dist'));
});

gulp.task('sass-lib', ['bower'], function() {
  return gulp.src('lib/font-awesome/scss/font-awesome.scss')
    .pipe(sass())
    .pipe(urlAdjuster({
      replace: ['../fonts', 'fonts']
    }))
    .pipe(gulp.dest('build/font-awesome'))
});

gulp.task('css',['sass', 'bower', 'sass-lib'], function() {
  return gulp.src(['lib/**/*.css', 'build/font-awesome/*.css', 'build/css/*.css'])
    .pipe(order([
      'lib/**/*.css',
      'build/css/*.css'
      ]))
    .pipe(concatCss('main.css'))
    .pipe(postcss([autoprefixer({browsers: ['last 5 version']})]))
    .pipe(gulp.dest('./build/'));
});

gulp.task('sass', function() {
  return gulp.src('./src/style/main.scss')
    .pipe(sass())
    .pipe(gulp.dest('./build/css'));
});