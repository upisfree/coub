var gulp = require('gulp'),
    uglify = require('gulp-uglify'),
    coffee = require('gulp-coffee'),
    nodemon = require('gulp-nodemon');

// gulp.task('release', function()
// {
//   return gulp.src('./src/index.coffee')
//              .pipe(coffeeify())
//              .pipe(uglify())
//              .pipe(gulp.dest('.'));
// });

gulp.task('dev', function()
{
  gulp.watch('./src/**/*.coffee', function()
  {
    gulp.src('./src/**/*.coffee')
        .pipe(coffee(
        {
          bare: true
        }))
        .pipe(gulp.dest('./bin'));

    nodemon(
    {
      script: './bin/index.js'
    });
  });
});

gulp.task('compile', function()
{
  gulp.src('./src/**/*.coffee')
      .pipe(coffee(
      {
        bare: true
      }))
      .pipe(gulp.dest('./bin'));
});