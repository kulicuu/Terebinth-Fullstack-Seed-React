arq = {}

# arq = assign arq, require('./side_effects/init.coffee').default


arq = assign arq, require('./side_effects/core.coffee').default


keys_arq = keys arq


side_effects_f = ({ store }) ->
    ({ state_js }) ->
        state = state_js
        for key_id, desire of state.lookup.desires
            if includes(keys_arq, desire.type)
                arq[desire.type] { desire , store }


exports.default = side_effects_f
