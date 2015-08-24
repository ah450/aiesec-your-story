var gulp = require('gulp');
var concat = require('gulp-concat');
var uglify = require("gulp-uglify");
var ngAnnotate = require('gulp-ng-annotate');
var jshint = require('gulp-jshint');
var coffee = require('gulp-coffee');
var coffeelint = require('gulp-coffeelint');
var stylishCoffee = require('coffeelint-stylish');
var gutil = require('gulp-util');
var order = require('gulp-order');
var modernizr = require('gulp-modernizr');

gulp.task('src-js', function() {
  return gulp.src(['src/**/*.js'])
    .pipe(jshint())
    .pipe(jshint.reporter('jshint-stylish'))
    .pipe(concat('app-src.js'))
    .pipe(gulp.dest('./build/temp'));
});

gulp.task('src-coffee', function() {
  return gulp.src(['src/**/*.coffee'])
    .pipe(coffeelint())
    .pipe(coffeelint.reporter(stylishCoffee))
    .pipe(coffee().on('error', gutil.log))
    .pipe(concat('coffee.js'))
    .pipe(gulp.dest('./build/temp'));
});

gulp.task('modernizr', function() {
  return gulp.src('src/modernize.coffee')
    .pipe(coffeelint())
    .pipe(coffeelint.reporter(stylishCoffee))
    .pipe(coffee().on('error', gutil.log))
    .pipe(modernizr())
    .pipe(gulp.dest('build/temp'));
});

gulp.task('libs', ['bower'], function() {
  return gulp.src('lib/**/*.js')
    .pipe(order([
      'lib/jquery/**/*.js',
      'lib/angular/*.js',
      'lib/**/*.js',
      ], { base: './'}))
    .pipe(concat('app-dependencies.js'))
    .pipe(gulp.dest('build/temp'));
})

gulp.task('scripts-no-tempaltes', ['libs', 'src-js', 'src-coffee', 'modernizr'], function() {
  return gulp.src(['build/temp/app-dependencies.js', 'build/temp/modernizr.js',
    'build/temp/app-src.js', 'build/temp/coffee.js'])
    .pipe(concat('app-no-template.js'))
    .pipe(gulp.dest('build/temp'));
});

gulp.task('scripts', ['scripts-no-tempaltes', 'templates', 'polyfills'], function() {
  return gulp.src(['build/temp/app-no-template.js', 'build/templates/*.js' ])
    .pipe(concat('app.js'))
    .pipe(gulp.dest('build/'));
});

gulp.task('uglify', ['scripts-no-tempaltes', 'templates-min', 'polyfills-min'], function() {
  return gulp.src(['build/temp/app-no-template.js', 'build/temp/templates.min.js'])
    .pipe(concat('app.js'))
    .pipe(ngAnnotate())
    // .pipe(uglify())
    .pipe(gulp.dest('dist/'));
});

gulp.task('polyfills', function() {
  return gulp.src('polyfills/**/*.js')
    .pipe(gulp.dest('build/polyfills'));
});

gulp.task('polyfills-min', function() {
  return gulp.src('polyfills/**/*.js')
    .pipe(uglify())
    .pipe(gulp.dest('dist/polyfills'));
});