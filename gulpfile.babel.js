import gulp from 'gulp';
import elm from 'gulp-elm';

gulp.task('elm-init', elm.init);

gulp.task('elm', ['elm-init'], () => {
  return gulp.src('src/*.elm')
    .pipe(elm())
    .pipe(gulp.dest('dist/'));
});

gulp.task('elm-bundle', ['elm-init'], () => {
  return gulp.src('src/*.elm')
    .pipe(elm.bundle('bundle.js'))
    .pipe(gulp.dest('dist/'));
});

gulp.task('default',['elm-bundle']);