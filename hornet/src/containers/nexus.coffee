

home = rc require('../scenes/home.coffee').default


ufo = rc require('../scenes/ufo.coffee').default
login = rc require('../scenes/ufo/login.coffee').default
register = rc require('../scenes/ufo/register.coffee').default



edit_profile = rc require('../scenes/edit_profile.coffee').default
cell = rc require('../scenes/cell.coffee').default

render = ->
    switch @props.navi
        when 'edit_profile'
            push_loc '#edit_profile'
            edit_profile()
        when 'cell'
            cell()
        when 'ufo'
            c 'going ufo'
            ufo()
        when 'login'
            login()
        when 'register'
            register()
        else
            div null, "Location Error"


comp = rr
    render: render

map_state_to_props = (state) ->
    state.get('hornet').toJS()

map_dispatch_to_props = (dispatch) ->
    {}



exports.default = connect(map_state_to_props, map_dispatch_to_props)(comp)
