



incoming_api = {}





# concord_channel['dctn_initial_blob'] = ({ state, action, data }) ->
#     state.setIn ['dctn_blob'], data.payload.blob



incoming_api.res_loginGo = ({ state, action, data }) ->
    if data.payload.status is "okGood"
        { client_token, hornet } = data.payload
        state = state.set 'navi', 'cell'
        state = state.set 'hornet', hornet
        state = state.set 'client_token', client_token
        state
    else
        state






exports.incoming = incoming_api










api = {}



api.loginGo = ({ state, action }) ->
    state = state.set 'mood_status', "justRegistered:waiting"
    state = state.setIn ['effects', shortid()],
        type: 'msg_server'
        payload:
            type: 'loginGo'
            payload: action.payload











exports.default = api
