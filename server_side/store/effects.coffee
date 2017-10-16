api = {}

api = fp.assign api, require('./effects/primus.coffee').default

# api = assign api, require('./effects/lounger.coffee').default

keys_api = _.keys api

effects_f = ({ Dispatch, env }) ->

    dispatch = (opts) ->
        Dispatch.emit 'new_action', { action: opts }

    # counter = 0

    ({ state }) ->
        for key_id, effect of state.get('effects').toJS()
            if _.includes(keys_api, effect.type)
                api[effect.type] { state, dispatch, effect }
            else
                c 'noop in side-effects with ', effect.type

exports.default = effects_f
