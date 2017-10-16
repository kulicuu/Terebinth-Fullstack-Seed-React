

api = {}

api = fp.assign api, require('./reducer/lounge_ufo.coffee')

keys_api = _.keys api

reducer = ({ state, action }) ->
    state = state.setIn ['effects'], Imm.Map({})
    if _.includes(keys_api, action.type)
        api[action.type] { state, action }
    else
        c 'noop in reducer with', action.type
        state

exports.default = reducer
