var gulp = require('gulp'),
    concat = require('gulp-concat'),
    uglify = require('gulp-uglify'),
    coffeeify = require('gulp-coffeeify');

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
    return gulp.src('./src/index.coffee')
               .pipe(coffeeify())
              // .pipe(uglify())
               .pipe(gulp.dest('./bin'));
  });
});