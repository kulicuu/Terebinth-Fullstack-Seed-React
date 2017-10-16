


api = {}

api = assign api, require('./reducer/lounge_ufo.coffee')

keys_api = keys api

reducer = ({ cs, state, action }) ->
    state = state.setIn ['effects'], Imm.Map({})
    if includes(keys_api, action.type)
        api[action.type] { cs, state, action }
    else
        c 'noop in reducer with', action.type
        state

exports.default = reducer
