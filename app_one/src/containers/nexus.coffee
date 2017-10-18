

home = rc require('../scenes/home.coffee').default


ufo = rc require('../scenes/ufo.coffee').default

render = ->
    ufo()
    # home()

comp = rr
    render: render

map_state_to_props = (state) ->
    {}

map_dispatch_to_props = (dispatch) ->
    {}

exports.default = connect(map_state_to_props, map_dispatch_to_props)(comp)
