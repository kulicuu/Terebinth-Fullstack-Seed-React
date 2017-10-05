



arq = {}


concord_channel = {}


concord_channel['res_build_selection'] = ({ state, action, data }) ->
    c data
    c data.payload, 'data.payload'
    { job_id } = data.payload
    state.setIn ['jobs', job_id, 'build_status'], 'completed_build'
    # state



# concord_channel['dctn_initial_blob'] = ({ state, action, data }) ->
#     state.setIn ['dctn_blob'], data.payload.blob





keys_concord_channel = keys concord_channel


arq['primus:data'] = ({ state, action }) ->
    { data } = action.payload
    { type, payload } = action.payload.data
    if includes(keys_concord_channel, type)
        concord_channel[type] { state, action, data }
    else
        state


# these that require primus write sideeffects can be
# handled by a single function from now on so additions
# should require code edits in fewer places.
arq['primus_hotwire'] = ({ state, action }) ->
    state.setIn ['desires', shortid()],
        type: 'primus_hotwire'
        payload: action.payload


# arq['search_struct'] = ({ state, action }) ->
#     state.setIn ['desires', shortid()],
#         type: 'search_struct_nodemem'
#         payload: action.payload





keys_arq = keys arq


lookup = (state, action) ->
    state = state.setIn ['desires'], Imm.Map({})
    if includes(keys_arq, action.type)
        arq[action.type]({ state, action })
    else
        c 'noop with ', action.type
        state


exports.default = lookup
