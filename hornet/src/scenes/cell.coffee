# Profile Home




{ styl_btn_two, styl_options_ctr, styl_ufo, h3_top, styl_btn_one } = require('../styles/ufo.coffee')


comp = rr

    # component

    getInitialState: ->
        if @props.hornet.profileCompletion is 'new_hornet'
            interaction_mode: 'introductions'
            intros_state: 'beginning'
        else

            interaction_mode: 'standard'

    componentWillReceiveProps: (nextProps) ->
        # if some condition in the hornet specs it we should start the introductions.
        if nextProps.hornet.profileCompletion is 'new_hornet'
            @setState
                interaction_mode: 'introductions'
                intros_state: 'beginning'
        else
            @setState
                interaction_mode: 'standard'



    render: ->
        switch @state.interaction_mode
            when 'introductions'
                switch @state.intros_state
                    when 'beginning'
                        div null, "beginning introductions"
                    else
                        div null, 'continuing introductions'

            else
                div
                    style: styl_ufo()
                    h3
                        style: h3_top()
                        "hornet :: open-source social-media pattern"
                    h3
                        style: h3_top()
                        "user profile hornet cell"


                    button
                        style: {}
                        "Logout"


map_state_to_props = (state) ->
    state.get('hornet').toJS()


map_dispatch_to_props = (dispatch) ->
    nav_register: ->
        dispatch { type: 'nav_register' }

    nav_login: ->
        dispatch { type : 'nav_login'}


exports.default = connect(map_state_to_props, map_dispatch_to_props)(comp)
