/**
 * Define Gulp Objects
 */
var gulp            = require('gulp'),
    autoprefixer    = require('gulp-autoprefixer'),
    coffee          = require('gulp-coffee'),
    concat          = require('gulp-concat'),
    fs              = require('fs'),
    flatten         = require('gulp-flatten'),
    include         = require('gulp-include'),
    minifyCss       = require('gulp-minify-css'),
    ngAnnotate      = require('gulp-ng-annotate'),
    plumber         = require('gulp-plumber'),
    sass            = require('gulp-sass'),
    uglify          = require('gulp-uglify'),
    watch           = require('gulp-watch'),
    yaml            = require('js-yaml');

// ----------------------------------------------------------------------------

/**
 * Define Configuration object
 */
var config = yaml.load(fs.readFileSync('gulp_config.yaml', 'utf-8'));

// ----------------------------------------------------------------------------

/**
 * Compile SASS into CSS
 */
gulp.task('Generate Styles', function () {
    gulp.src(config.src.sass)
        .pipe(plumber())
        .pipe(sass())
        .pipe(autoprefixer("> 1%"))
        .pipe(gulp.dest(config.dest.css))
        .pipe(minifyCss())
        .pipe(gulp.dest(config.dest.css));
});

// ----------------------------------------------------------------------------

/**
 * Compile CoffeeScript and Angular Code into JS
 */
gulp.task('Generate Scripts', function () {
    gulp.src(config.src.coffee)
        .pipe(plumber())
        .pipe(include())
        .pipe(coffee({bare: true}))
        .pipe(ngAnnotate())
        .pipe(gulp.dest(config.dest.js));
});

// ----------------------------------------------------------------------------

/**
 * Compile Bower files
 */
gulp.task('Compress Third Party Files', function () {
    // Combine JS Files
    gulp.src(config.third_party.js)
        .pipe(uglify())
        .pipe(concat('dependencies.min.js'))
        .pipe(gulp.dest(config.dest.js));

    // Combine CSS files
    gulp.src(config.third_party.css)
        .pipe(minifyCss())
        .pipe(concat('dependencies.min.css'))
        .pipe(gulp.dest(config.dest.css));

    // Flatten fonts
    gulp.src(config.third_party.fonts)
        .pipe(flatten())
        .pipe(gulp.dest(config.dest.fonts));
});

// ----------------------------------------------------------------------------

/**
 * Create Watch Scripts
 */
gulp.task('Create Watch Scripts', function () {
    watch({glob: config.src.coffee, emitOnGlob: false}, ['Generate Scripts']);
    watch({glob: config.src.sass, emitOnGlob: false}, ['Generate Styles']);
});

// ----------------------------------------------------------------------------

/**
 * Default task
 */
gulp.task('default', [
    'Generate Scripts',
    'Generate Styles',
    'Compress Third Party Files',
    'Create Watch Scripts'
]);
