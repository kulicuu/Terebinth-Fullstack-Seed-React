

{ styl_btn_two, styl_options_ctr, styl_ufo, h3_top, styl_btn_one } = require('../styles/ufo.coffee')


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
            div
                style: styl_options_ctr()

                button
                    style: styl_btn_two()
                    onClick: -> @props.nav_login()
                    "login"

                button
                    style: styl_btn_one()
                    onClick: -> @props.nav_register()
                    "register"



map_state_to_props = (state) ->
    state.get('hornet').toJS()


map_dispatch_to_props = (dispatch) ->
    nav_register: ->
        dispatch { type: 'nav_register' }

    nav_login: ->
        dispatch { type : 'login'}


exports.default = connect(map_state_to_props, map_dispatch_to_props)(comp)
