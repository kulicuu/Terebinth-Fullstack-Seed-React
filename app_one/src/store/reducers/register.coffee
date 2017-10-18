



api = {}



api.registerGo = ({ state, action }) ->
    state = state.set 'mood_status', "justRegistered:waiting"
    c action.payload, 'action.payload'
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

api.nav_register = ({ state, action }) ->
    c 'going'
    state.set 'navi', 'register'









exports.default = api
