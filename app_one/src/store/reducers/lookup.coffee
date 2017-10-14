



api = {}


incoming_effects_api = {}


# concord_channel['dctn_initial_blob'] = ({ state, action, data }) ->
#     state.setIn ['dctn_blob'], data.payload.blob


keys_incoming_effects_api = keys incoming_effects_api


api['primus:data'] = ({ state, action }) ->
    { data } = action.payload
    { type, payload } = action.payload.data
    if includes(keys_incoming_effects_api, type)
        incoming_effects_api[type] { state, action, data }
    else
        state


# these that require primus write sideeffects can be
# handled by a single function from now on so additions
# should require code edits in fewer places.
api['primus_hotwire'] = ({ state, action }) ->
    state.setIn ['effects', shortid()],
        type: 'primus_hotwire'
        payload: action.payload


# arq['search_struct'] = ({ state, action }) ->
#     state.setIn ['desires', shortid()],
#         type: 'search_struct_nodemem'
#         payload: action.payload





keys_api = keys api


lookup = (state, action) ->
    state = state.setIn ['effects'], Imm.Map({})
    if includes(keys_api, action.type)
        api[action.type]({ state, action })
    else
        c 'noop with ', action.type
        state


exports.default = lookup
