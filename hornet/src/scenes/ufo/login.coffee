


{
    styl_register_ctr
    , styl_btn_registerGo
    , styl_btn_return
    , styl_btn_two, styl_options_ctr, styl_ufo, h3_top, styl_btn_one
    , styl_email_ipt
    , styl_pwd_ipt
    , styl_register
} = require('../../styles/ufo.coffee')

comp = rr
    getInitialState: ->
        mood_status: 'ready'
        email: null
        pwd: null

    render: ->
        div
            style: styl_ufo()
            h3
                style: h3_top()
                "login"
            input
                style: styl_email_ipt()
                placeholder: 'Email'
                type: 'text'
                disabled: @state.mood_status is 'justLogggedIn:waiting'
                onChange: (e) =>
                    @setState
                        email: e.currentTarget.value
            input
                style: styl_pwd_ipt()
                disabled: @state.mood_status is 'justLogggedIn:waiting'
                placeholder: 'Password'
                onChange: (e) =>
                    @setState
                        pwd: e.currentTarget.value
            button
                style: styl_btn_registerGo()
                disabled: (@state.mood_status is 'justLogggedIn:waiting') or (@state.mood_status isnt 'ready')
                onClick: =>
                    @setState
                        mood_status: 'justLogggedIn:waiting'
                    @props.loginGo
                        email: @state.email
                        pwd: @state.pwd
                "LOGIN"


map_state_to_props = (state) ->
    state.get('hornet').toJS()


map_dispatch_to_props = (dispatch) ->
    loginGo: ({ email, pwd }) ->
        dispatch
            type: 'loginGo'
            payload: { email, pwd }



exports.default = connect(map_state_to_props, map_dispatch_to_props)(comp)
