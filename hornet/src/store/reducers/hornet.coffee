

api = {}
api = fp.assign api, require('./navigation.coffee').default
# api = fp.assign api, require('./ufo.coffee').default
api = fp.assign api, require('./register.coffee').default
api = fp.assign api, require('./login.coffee').default



incoming_effects_api = {}
incoming_effects_api = fp.assign incoming_effects_api, require('./register.coffee').incoming
incoming_effects_api = fp.assign incoming_effects_api, require('./login.coffee').incoming



incoming_effects_api.res_wakeup = ({ state, action, data }) ->
    c data.payload
    c '993939393939393939'
    if data.payload.status is "OkClear"
        c 'is'
        { hornet, clientToken } = data.payload
        state = state.set 'navi', 'cell'
        state = state.set 'hornet', hornet
        state = state.set 'client_token', clientToken
        state = state.set 'mood_status', 'hornet_cell'
        state = state.setIn ['effects', shortid()],
            type: 'set_clientToken'
            payload: { clientToken }
        state
    else
        c 'isnt'
        state




keys_incoming_effects_api = keys incoming_effects_api



api.res_fetch_clientToken = ({ state, action }) ->
    c 'basic 001'
    { clientToken } = action.payload
    state = state.set 'clientToken', clientToken
    if clientToken isnt null
        state = state.setIn ['effects', shortid()],
            type: 'msg_server'
            payload:
                type: 'wakeup_refresh_w_clientToken'
                payload: { clientToken }

    else
        state = state.set 'mood_status', 'ufo'
        state = state.set 'navi', 'ufo'


    state



api['primus:data'] = ({ state, action }) ->
    c 'basic 000'
    { data } = action.payload
    { type, payload } = action.payload.data
    if includes(keys_incoming_effects_api, type)
        c " has key"
        incoming_effects_api[type] { state, action, data }
    else
        c "No Op in primus:data handler of main reducer. With type: ", type
        state


# these that require primus write sideeffects can be
# handled by a single function from now on so additions
# should require code edits in fewer places.
api['primus_hotwire'] = ({ state, action }) ->
    state.setIn ['effects', shortid()],
        type: 'primus_hotwire'
        payload: action.payload


keys_api = keys api


hornet = (state, action) ->
    c 'store is dispatched'
    state = state.setIn ['effects'], Imm.Map({})
    if includes(keys_api, action.type)
        c 'has effect'
        api[action.type]({ state, action })
    else
        c 'No Op returned on type: ', action.type
        state


exports.default = hornet
