api = {}

# arq = assign arq, require('./side_effects/init.coffee').default


api = fp.assign api, require('./effects/core.coffee').default


keys_api = keys api


effects_f = ({ store }) ->
    ({ state_js }) ->
        state = state_js
        for key_id, effect of state.hornet.effects
            { type, payload } = effect
            if _.includes(keys_api, effect.type)
                api[effect.type] { effect , store }
            else
                c "No Op in effects on type:", type

exports.default = effects_f
