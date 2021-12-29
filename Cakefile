{spawn, exec} = require 'child_process'

build = (done) ->
    console.log "Building"
    exec './node_modules/.bin/coffee --compile --output lib/ src/', (err, stdout, stderr) ->
        process.stderr.write stderr
        return done err if err

        process.stderr.write stderr
        done?()

run = (fn) ->
    ->
        fn (err) ->
            console.log err.stack if err

task 'build', "Build project from src/*.coffee to lib/*.js", run build
