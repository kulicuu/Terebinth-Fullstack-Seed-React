

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
        email: null
        pwd: null
        candide: null



    render: ->
        div
            style : styl_register_ctr()
            div
                style: styl_register()
                h3
                    style: h3_top()
                    "register"

                input
                    style: styl_email_ipt()
                    placeholder: 'Email'
                    type: 'text'
                    onChange: (e) =>
                        @props.check_avail { candide : e.currentTarget.value }
                        @setState
                            email: e.currentTarget.value
                            candide: e.currentTarget.value

                input
                    style: styl_pwd_ipt()
                    placeholder: 'password'
                    type: 'password'
                    onChange : (e) =>
                        @setState
                            pwd: e.currentTarget.value


                button
                    style: styl_btn_registerGo()
                    onClick: => @props.registerGo
                        email: @state.email
                        pwd: @state.pwd
                    "Register!"

                button
                    style: styl_btn_return()
                    onClick: @props.nav_ufo
                    "Return"




map_state_to_props = (state) ->
    state.get('hornet').toJS()


map_dispatch_to_props = (dispatch) ->

    registerGo: ({ email, pwd }) ->
        dispatch
            type: 'registerGo'
            payload: { email, pwd }

    check_avail: ({candide}) ->
        dispatch { type: 'register_check_avail', payload: { candide } }

    nav_ufo: ->
        dispatch { type: 'nav_ufo' }

    nav_login: ->
        dispatch { type : 'login'}


exports.default = connect(map_state_to_props, map_dispatch_to_props)(comp)
