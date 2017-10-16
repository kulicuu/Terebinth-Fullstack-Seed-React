
# process.on 'uncaughtException', (err)->
#     c err
#     process.exit(0)

EventEmitter = require 'events'
class Emitter extends EventEmitter
Dispatch = new Emitter()

process.setMaxListeners 10000

module.exports = ({ cs, env, redis, helsinki_primus }) ->

    require './modules/globals.coffee'

    state = require('./initial_state.coffee')
        env: env
        helsinki_primus: helsinki_primus
        redis: redis

    reducer = require('./reducer.coffee').default

    effects = require('./effects.coffee').default { Dispatch, cs, env }

    Dispatch.on 'new_action', ({ action }) ->
        state = reducer { state, action }
        effects { state }

    effects { state }
