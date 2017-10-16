api = {}

api = assign api, require('./side_effects/system_primus.coffee').default

api = assign api, require('./side_effects/lounger.coffee').default

keys_api = keys api

side_effects_f = ({ cs, Dispatch, env }) ->

    dispatch = (opts) ->
        Dispatch.emit 'new_action', { action: opts }

    # counter = 0

    ({ cs, state }) ->
        # c counter++
        for key_id, effect of state.get('effects').toJS()
            if includes(keys_api, effect.type) is true
                api[desire.type] { cs, state, dispatch, effect }
            else
                c 'noop in side-effects with ', desire.type

exports.default = side_effects_f
