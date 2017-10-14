arq = {}

# arq = assign arq, require('./side_effects/init.coffee').default


arq = assign arq, require('./effects/core.coffee').default


keys_arq = keys arq


effects_f = ({ store }) ->
    ({ state_js }) ->
        state = state_js
        for key_id, effect of state.lookup.effects
            if includes(keys_arq, effect.type)
                arq[effect.type] { effect , store }


exports.default = effects_f
