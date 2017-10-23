# Edit Profile


flx_col =
    display: 'flex'
    flexDirection: 'column'


{ styl_btn_two, styl_options_ctr, styl_ufo, h3_top, styl_btn_one } = require('../styles/ufo.coffee')


comp = rr

    getInitialState: ->
        user_location: null
        user_realName: null
        username: null
        imagePreviewUrl: ""

    componentWillReceiveProps: (nextProps) ->


    previewFile: ->


    render: ->
        c 'props in edit profile', @props
        div
            style:
                display: 'flex'
                alignItems: 'center'
                justifyContent: 'center'
            div
                style: fp.assign flx_col, {}

                input
                    type: 'file'
                    onChange: (e) =>
                        c 'image change', e
                        e.preventDefault()
                        file = e.target.files[0]
                        reader = new FileReader()
                        reader.onloadend = =>
                            @setState
                                file: file
                                imagePreviewUrl: reader.result
                        reader.readAsDataURL file

                img
                    src: @state.imagePreviewUrl
                    width: .2 * ww
                    height: .2 * ww

                div
                    style:
                        background: "url(#{@state.imagePreviewUrl}) 50% 50% no-repeat"
                        width: .2 * ww
                        height: .2 * ww

                input
                    type: 'text'
                    placeholder: 'Username'
                    onChange: (e) =>
                        @setState
                            username: e.currentTarget.value
                    style:
                        fontFamily: 'sans'
                input
                    type: 'text'
                    placeholder: 'Name (first, last)'
                    onChange: (e) =>
                        @setState
                            user_realName: e.currentTarget.value
                    style:
                        fontFamily: 'sans'
                input
                    type: 'text'
                    placeholder: 'Location'
                    onChange: (e) =>
                        @setState
                            user_location: e.currentTarget.value
                    style:
                        fontFamily: 'sans'

                button
                    onClick: =>
                        @props.update_profile
                            nu_hornet: _.reduce @state, (acc, v, k) =>
                                if v isnt null
                                    acc[k] = v
                            , {}
                    "Save"
                button
                    onClick: @props.nav_cell
                    "to Cell"
            div
                style: fp.assign flx_col, {}




map_state_to_props = (state) ->
    state.get('hornet').toJS()


map_dispatch_to_props = (dispatch) ->

    update_profile: ({ nu_hornet }) ->
        dispatch
            type: 'update_profile'
            nu_hornet: nu_hornet

    nav_cell: ->
        dispatch { type: 'nav_cell' }

    logout: ->
        dispatch { type: 'logout' }





exports.default = connect(map_state_to_props, map_dispatch_to_props)(comp)
