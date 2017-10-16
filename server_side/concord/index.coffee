
# process.on 'uncaughtException', (err)->
#     c err
#     process.exit(0)

EventEmitter = require 'events'
class Emitter extends EventEmitter
Dispatch = new Emitter()

process.setMaxListeners 10000

module.exports = ({ env, app_one_primus }) ->


    state = require('./initial_state.coffee') { env, app_one_primus }

    reducer = require('./reducer.coffee').default

    effects = require('./effects.coffee').default { Dispatch, env }

    Dispatch.on 'new_action', ({ action }) ->
        state = reducer { state, action }
        effects { state }

    effects { state }
