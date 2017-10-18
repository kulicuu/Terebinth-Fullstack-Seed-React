

{ styl_ufo, h3_top } = require('../styles/ufo.coffee')


comp = rr
    getInitialState: ->
        klass: 'ufo'

    render: ->
        c 'rendiring'
        div
            style: styl_ufo()
            h3
                style: h3_top()
                "hornet :: open-source social-media pattern"


map_state_to_props = (state) ->
    state.get('lookup').toJS()


map_dispatch_to_props = (dispatch) ->
    {}


exports.default = connect(map_state_to_props, map_dispatch_to_props)(comp)
