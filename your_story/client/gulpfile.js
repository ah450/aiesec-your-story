var gulp = require('gulp');
var fs = require('fs');
var watch = require('gulp-watch');
var requireDir = require('require-dir');
var gzip = require('gulp-gzip');
var rimraf = require('rimraf');
requireDir('./gulp-tasks');


gulp.task('clean', function() {
  var dirs = ['dist', 'build', 'lib', 'build/temp', 'build/test', 'compiledSpecs'];
  dirs.forEach(function(dir) {
    try {
      rimraf.sync(dir);
      fs.mkdirSync(dir);
    } catch(e) {
      if (e.code != 'EEXIST') {
        throw e;
      }
    }
  });
});

gulp.task('dummy_dev_helper', ['assets', 'scripts', 'css', 'manifest']);

gulp.task('dummy_dev', ['clean'], function() {
  return gulp.start('dummy_dev_helper');
});



gulp.task('watch', function() {
  watch(['./src/**', './images/**', './polyfills/**'], function() {
    gulp.start('reload');
  });
});



gulp.task('dev', ['clean'], function() {
  return gulp.start('webserver-watch');
});

gulp.task('default', ['dev']);


gulp.task('dist', ['clean'], function() {
  return gulp.start('compress');
});

gulp.task('compress', ['uglify', 'css-min', 'assets', 'manifest-dist'], function() {
  return gulp.src('dist/**/*.{html,css,js,eot,svg,ttf}')
    .pipe(gzip({
      append: true,
      gzipOptions: {
        level: 6
      }
    }))
    .pipe(gulp.dest('dist'));
});


gulp.task('rails:production', ['dist'], function() {
  return gulp.src('dist/**/*')
    .pipe(gulp.dest('../public'));
});

gulp.task('rails:dev', ['dummy_dev'], function() {
  return gulp.src('build/**/*')
    .pipe(gulp.dest('../public'));
});