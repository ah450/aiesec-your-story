var gulp = require('gulp');
var shell = require('gulp-shell');

gulp.task('rails-start', shell.task([
  'RAILS_ENV=test bundle exec rails s -p 3000 -d'
]));

gulp.task('rails-kill', shell.task([
  'kill `cat ../tmp/pids/server.pid`'
]));

gulp.task('setup-db', shell.task([
  'RAILS_ENV=test bundle exec rake --trace db:drop',
  'RAILS_ENV=test bundle exec rake --trace db:create',
  'RAILS_ENV=test bundle exec rake --trace db:migrate',
  'RAILS_ENV=test bundle exec rake --trace db:seed'
]));
