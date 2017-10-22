# Edit Profile


flx_col =
    display: 'flex'
    flexDirection: 'column'


{ styl_btn_two, styl_options_ctr, styl_ufo, h3_top, styl_btn_one } = require('../styles/ufo.coffee')


comp = rr

    getInitialState: ->
        {}

    componentWillReceiveProps: (nextProps) ->




    render: ->
        c 'hornet', @props.hornet
        div
            style:
                display: 'flex'
                alignItems: 'center'
                justifyContent: 'center'
            div
                style: fp.assign flx_col, {}
                input
                    type: 'text'
                    placeholder: 'Username'
                    style:
                        fontFamily: 'sans'
                input
                    type: 'text'
                    placeholder: 'Name (first, last)'
                    style:
                        fontFamily: 'sans'
                input
                    type: 'text'
                    placeholder: 'Location'
                    style:
                        fontFamily: 'sans'

                button
                    onClick: @props.update_profile
                    "Save"
                button
                    onClick: @props.nav_cell
                    "to Cell"
            div
                style: fp.assign flx_col, {}




map_state_to_props = (state) ->
    state.get('hornet').toJS()


map_dispatch_to_props = (dispatch) ->

    nav_cell: ->
        dispatch { type: 'nav_cell' }

    logout: ->
        dispatch { type: 'logout' }





exports.default = connect(map_state_to_props, map_dispatch_to_props)(comp)
