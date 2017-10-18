

home = rc require('../scenes/home.coffee').default


ufo = rc require('../scenes/ufo.coffee').default
login = rc require('../scenes/ufo/login.coffee').default
register = rc require('../scenes/ufo/register.coffee').default

render = ->
    switch @props.navi
        when 'ufo'
            ufo()
        when 'login'
            login()
        when 'register'
            register()
        else
            # home()


comp = rr
    render: render

map_state_to_props = (state) ->
    state.get('hornet').toJS()

map_dispatch_to_props = (dispatch) ->
    {}



exports.default = connect(map_state_to_props, map_dispatch_to_props)(comp)
