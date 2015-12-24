var gulp = require('gulp');

function processAssets() {
  return gulp.src(['images/**/*', 'assets/**/*' ], {base: '.'});
}


exports.processAssets = processAssets;