



incoming_api = {}





# concord_channel['dctn_initial_blob'] = ({ state, action, data }) ->
#     state.setIn ['dctn_blob'], data.payload.blob



incoming_api.res_registerGo = ({ state, action, data }) ->
    if data.payload.status is "okGood"
        c data.payload, 'data.payload'
        { clientToken, hornet } = data.payload
        push_loc '#cell'
        state = state.set 'navi', 'cell'
        state = state.set 'hornet', hornet
        state = state.set 'client_token', clientToken
        state = state.setIn ['effects', shortid()],
            type: 'set_clientToken'
            payload: { clientToken }
        state
    else
        state






exports.incoming = incoming_api





api = {}



api.registerGo = ({ state, action }) ->
    state = state.set 'mood_status', "justRegistered:waiting"
    state = state.setIn ['effects', shortid()],
        type: 'msg_server'
        payload:
            type: 'registerGo'
            payload: action.payload
                # email: action.payload.email
                # pwd: action.payload.pwd

api.register_check_avail = ({ state, action }) ->
    state = state.setIn ['effects', shortid()],
        type: 'msg_server'
        payload:
            type: 'register_check_avail'
            payload: action.payload
                # candide: action.payload.candide











exports.default = api
