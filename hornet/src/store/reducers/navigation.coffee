



api = {}


api.nav_ufo = ({ state, action }) ->
    state.set 'navi', 'ufo'


api.nav_login = ({ state, action }) ->
    state.set 'navi', 'login'

api.nav_register = ({ state, action }) ->
    c 'going'
    state.set 'navi', 'register'









exports.default = api
