var gulp = require('gulp'),
    uglify = require('gulp-uglify'),
    coffeeify = require('gulp-coffeeify'),
    nodemon = require('gulp-nodemon');

gulp.task('release', function()
{
  return gulp.src('./src/index.coffee')
             .pipe(coffeeify())
             .pipe(uglify())
             .pipe(gulp.dest('.'));
});

gulp.task('dev', function()
{
  gulp.watch('./src/**/*.coffee', function()
  {
    gulp.src('./src/index.coffee')
        .pipe(coffeeify())
        .pipe(gulp.dest('./bin'));

    nodemon({
      script: './bin/index.js'
    })
  });
});