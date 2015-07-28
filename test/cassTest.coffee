assert = require 'assert'
durations = require 'durations'
waitForPg = require '../src/index.coffee'

describe "wait-for-cassandra", ->
    it "should retry until cassandra is up", (done) ->
        watch = durations.stopwatch().start()

        # TODO: test wait for connection

    it "should timeout after waiting the max timeout", (done) ->
        watch = durations.stopwatch().start()

        # TODO: test timeout

