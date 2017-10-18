



api = {}


api.register_check_avail = ({ state, action }) ->
    state = state.setIn ['effects', shortid()],
        type: 'generic_primus_write'
        payload:
            type: 'register_check_avail'
            payload:
                candide: action.payload.candide

api.nav_register = ({ state, action }) ->
    c 'going'
    state.set 'navi', 'register'









exports.default = api
