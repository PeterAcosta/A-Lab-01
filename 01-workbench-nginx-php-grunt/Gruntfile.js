// Este es el archivo de configuracion de Grunt

module.exports = function(grunt) {

    var CSS_ORIGIN='sources/CSS/*.css'
    var CSS_FILE='www/_test.min.css';
    var CSS_MAP_FILE='www/_test.min.css.map';

    var JS_ORIGIN='sources/JS/*.js'
    var JS_FILE='www/_test.min.js';
    var JS_MAP_FILE='www/_test.min.js.map';

    var PHP_ORIGIN='sources/PHP/*.php'
    var PHP_FILE='www/_test.php';


    // Project configuration. ------------------------------------------------------------------------------------------
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        // Carpeta auxliar
        auxiliar: {
            path: '_auxiliar/zGrunt'
        },

        // -------------------------------------------------------------------------------------------------------------
        verbosity: {
            // Default

            // Output is rewritten on the line to show progress but save space
            option1: {
                options: { mode: 'dot' },
                tasks: ['concat:php_functions']
            },
            option2: {
                options: { mode: 'dot' },
                tasks: ['concat:php_classes']
            },
            option3: {
                options: { mode: 'dot' },
                tasks: ['concat:php_scripts']
            }
        },

        // -------------------------------------------------------------------------------------------------------------
        cssmin: {
            options: {
                banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n',
                sourceMap: true,
                // sourceMapName: 'www/_ceconet3.min.css.map'
                sourceMapName: CSS_MAP_FILE
            },
            build: {
                // src: 'sources/CSS/*.css',
                src:  CSS_ORIGIN,
                // dest: 'www/_ceconet3.min.css'
                dest: CSS_FILE
            }
        },


        // -------------------------------------------------------------------------------------------------------------
        uglify: {
            options: {
                banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */',
                mangle: true ,       // cambia los nombres de las variables
                compress : false,
                sourceMap: true,
                // sourceMapName: 'www/_ceconet3.min.js.map'
                sourceMapName: JS_MAP_FILE

            },
            build: {
                // src: 'sources/JS/*.js',
                src:  JS_ORIGIN,
                // dest: 'www/_ceconet3.min.js'
                dest: JS_FILE
            }
        },

        // -------------------------------------------------------------------------------------------------------------
        phpmin: {
            options: {
                concat: true,
                singleline: true,   // remueve los comentarios de una sola linea
                multiline: true,    // remueve los comentarios de muchas lineas
                tabs: false,        // remueve los tabs , 2 o mas espacios ( ojo con esto )
                newline: false      // remueve el salto de linea
            },
            php_functions: {
                // PHP-functions
                files: [{
                    expand: true,
                    cwd: 'sources/PHP/',
                    src: '*.php',
                    dest: '<%= auxiliar.path %>/PHP-functions/'
                }]
            },
            php_classes: {
                // PHP-classes
                files: [{
                    expand: true,
                    cwd: 'sources/PHP-classes/',
                    src: '*.php',
                    dest: '<%= auxiliar.path %>/PHP-classes/'
                }]
            },
            php_scripts: {
                // PHP-scripts
                files: [{
                    expand: true,
                    cwd: 'sources/PHP-scripts/',
                    src: '*.php',
                    dest: '<%= auxiliar.path %>/PHP-scripts/'
                }]
            },

            /*
            php_functions_max_to_min: {
                // PHP-functions MAX to min
                options: {
                    concat: true,
                    singleline: true,   // remueve los comentarios de una sola linea
                    multiline: true,    // remueve los comentarios de muchas lineas
                    tabs: true,         // remueve los tabs
                    newline: true       // remueve el salto de linea
                },
                src: '_ceconet24_v2.php',
                dest: '_ceconet24_v2.min.php'
            }*/
            
        },
        // -------------------------------------------------------------------------------------------------------------
        concat: {
            php_functions: {
                options: {
                    // banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - ' + '<%= grunt.template.today("yyyy-mm-dd") %> */\n',
                    separator : '\n\n\n' ,
                    footer: '\n/* este es el pie */',
                    language:{
                        type:'php',
                        opentag: '<?php /*! <%= pkg.name %> - v<%= pkg.version %> - ' + '<%= grunt.template.today("dd-mm-yyyy") %> */\n',
                        closetag:'',
                        rmSpace:true,
                        rmClose:true
                    },
                    process: function(src, filepath) {
                        return '// ------------------------------------------------------------------------- source: ' + filepath + '\n' + src.replace(/(^|\n)[ \t]*('use strict'|"use strict");?\s*/g, '$1');
                    }
                },
                src: '<%= auxiliar.path %>/PHP-functions/*.php',
                // dest: 'www/_ceconet3.php'
                dest: PHP_FILE
            },

            php_classes: {
                options: {
                    language:{
                        type:'php',
                        opentag: '<?php /*! <%= pkg.name %> - <%= grunt.template.today("dd-mm-yyyy") %> */\n',
                        closetag:'',
                        rmSpace:true,
                        rmClose:true
                    }
                },
                files: [{
                    expand: true,
                    cwd: '<%= auxiliar.path %>/PHP-classes/',
                    src: '*.php',
                    dest: 'www/_classes/'
                }]
            },

            php_scripts: {
                options: {
                    language:{
                        type:'php',
                        opentag: '<?php /*! <%= pkg.name %> - <%= grunt.template.today("dd-mm-yyyy") %> */\n',
                        closetag:'',
                        rmSpace:true,
                        rmClose:true
                    }
                },
                files: [{
                    expand: true,
                    cwd: '<%= auxiliar.path %>/PHP-scripts/',
                    src: '*.php',
                    dest: 'www/_scripts/'
                }]
            }




        },


        // -------------------------------------------------------------------------------------------------------------
        // -------------------------------------------------------------------------------------------------------------
        watch: {
            options: {
                livereload: true
            },
            css: {
                // files: ['sources/CSS/*.css'],
                files: ['<%= cssmin.build.src %>'],
                tasks: ['cssmin']
            },
            js: {
                // files: ['__source/JS/*.js'],
                files: ['<%= uglify.build.src %>'],
                tasks: ['uglify']
            },
            // functions
            phpmin_php_functions:{
                files: ['sources/PHP-functions/*.php'],
                tasks: ['phpmin:php_functions']
            },
            concat_php_functions:{
                files: ['<%= concat.php_functions.src %>'],
                tasks: ['concat:php_functions']
            },
            // classes
            phpmin_php_classes:{
                files: ['sources/PHP-classes/*.php'],
                tasks: ['phpmin:php_classes']
            },
            concat_php_classes:{
                files: ['<%= auxiliar.path %>/PHP-classes/*.php'],
                tasks: ['concat:php_classes']
            },
            // scripts
            phpmin_php_scripts:{
                files: ['sources/PHP-scripts/*.php'],
                tasks: ['phpmin:php_scripts']
            },
            concat_php_scripts:{
                files: ['<%= auxiliar.path %>/PHP-scripts/*.php'],
                tasks: ['concat:php_scripts']
            },

            // php_functions_max_to_min:{
            //     files: ['<%= phpmin.php_functions_max_to_min.src %>'],
            //     tasks: ['phpmin:php_functions_max_to_min']
            // }

        }


    });



    // Load the plugin that provides the "uglify" task.
    grunt.loadNpmTasks('grunt-contrib-cssmin');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-phpmin');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-concat-language');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-verbosity');



    // Default task(s).
    // grunt.registerTask('default', ['verbosity','concat','phpmin','uglify','cssmin','watch']);
    // grunt.registerTask('buil', ['concat','phpmin','uglify','cssmin']);

    grunt.registerTask('default', ['verbosity','phpmin','concat','uglify','cssmin','watch']);
    grunt.registerTask('buil', ['phpmin','concat','uglify','cssmin']);


};

