var gulp = require('gulp');
var concat = require('gulp-concat');
var mainBowerFiles = require('main-bower-files');
var watch = require('gulp-watch');
var coffee = require('gulp-coffee');
var coffeelint = require('gulp-coffeelint');
var stylishCoffee = require('coffeelint-stylish');
var gutil = require('gulp-util');
var runSequence = require('run-sequence');
var karma = require('karma').server;

gulp.task('app-test-src', ['src-coffee', 'src-js', 'bower-install', 'modernizr', 'templates'], function() {
  var srces = mainBowerFiles({
      includeDev: 'inclusive'
    }).filter(function(s) {
      return s.endsWith('.js');
    });
  srces = srces.concat(['build/temp/modernizr.js', 'build/templates/*.js',
    'build/temp/app-src.js', 'build/temp/coffee.js']);
  return gulp.src(srces)
    .pipe(concat('app-testing.js'))
    .pipe(gulp.dest('build/test'));
});

gulp.task('spec-src', function() {
  return gulp.src('spec/**/*.coffee')
    .pipe(coffeelint())
    .pipe(coffeelint.reporter(stylishCoffee))
    .pipe(coffee().on('error', gutil.log))
    .pipe(gulp.dest('compiledSpecs'));
});

gulp.task('testActual', ['app-test-src', 'spec-src'], function() {
  karma.start({
    configFile: __dirname + '/../karma.conf.js',
    singleRun: true
  });

});

gulp.task('test', ['clean'], function(done) {
  return runSequence('webserver', 'testActual', 'rails-kill');
});

gulp.task('tdd', function() {
  watch(['./src/**', './images/**', './polyfills/**', './spec/**'], function() {
    gulp.start('test');
  });
});
