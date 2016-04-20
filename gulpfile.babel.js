import gulp from 'gulp';
import typescript from 'gulp-typescript';
import babel from 'gulp-babel';
import mocha from 'gulp-mocha';
import elm from 'gulp-elm';
import webpack from 'webpack-stream';
import 'babel-polyfill';

gulp.task('elm-init', elm.init);

gulp.task('compile', ['elm-init'], () => {
    return gulp.src('./src/**/*.elm*')
        .pipe(elm())
        .pipe(gulp.dest('./build'));
});

gulp.task('package', ['compile'],function() {
    return gulp.src('./build/code/main.js')
        .pipe(webpack({
            devtool: 'sourse-map',
            output: {
                filename: 'bundle.js'
            }
        }))
        .pipe(gulp.dest('./dist'));
});

gulp.task('watch',['package'],function(){
    gulp.watch(['./src/**/*.ts'],['package']);
})

gulp.task('default',['package']);