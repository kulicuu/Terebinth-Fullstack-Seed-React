

styl_btn_registerGo = ->
    width: .3 * ww
    height: .3 * wh
    backgroundColor: 'magenta'
    color: 'snow'
    fontFamily: 'sans'
    fontSize: .2 * wh


styl_btn_return = ->


styl_register_ctr = ->
    display: 'flex'
    alignItems: 'center'
    justifyContent: 'center'
    height:  wh


styl_register = ->
    display: 'flex'
    flexDirection: 'column'
    justifyContent: 'space-between'

    alignItems: 'center'
    width: .6 * ww
    height: .8 * wh




styl_login = ->
    # textAlign: 'center'


styl_pwd_ipt = ->
    width: .18 * ww
    height: .12 * wh
    textAlign: 'center'
    fontSize: .08 * wh
    color: 'gold'
    backgroundColor: 'beige'


styl_email_ipt = ->
    color: 'gold'
    backgroundColor: 'azure'
    width: .72 * ww
    height: .12 * wh
    textAlign: 'center'
    fontSize: .08 * wh
    backgroundColor: 'azure'

styl_options_ctr = ->
    display: 'flex'
    flexDirection: 'column'
    alignItems: 'center'
    justifyContent: 'space-between'
    height: .6 * wh
    width: ww

styl_btn_one = ->
    width: .12 * ww
    height: .048 * wh
    # borderRadius: .02 * wh
    fontFamily: 'sans'
    fontSize: .02 * wh
    color: 'darkslategrey'
    backgroundColor: 'ivory'
    cursor: 'pointer'

styl_btn_two = ->
    width: .2 * ww
    height: .2 * wh
    borderRadius: .02 * wh
    fontFamily: 'sans'
    fontSize: .045 * wh
    color: 'darkslategrey'
    backgroundColor: 'ivory'
    cursor: 'pointer'


styl_ufo = ->
    display: 'flex'
    flexDirection: 'column'
    backgroundColor: 'floralwhite'
    alignItems: 'center'


h3_top = ->
    fontFamily: 'sans'
    fontSize: .04 * wh
    marginBottom: .2 * wh
    marginTop: .1 * wh
    cursor: 'pointer'
    color: 'chartreuse'







module.exports = {
    styl_email_ipt
    , styl_btn_registerGo
    , styl_btn_return
    , styl_register_ctr
    , styl_register
    , styl_pwd_ipt
    , styl_btn_two, styl_options_ctr, h3_top, styl_register, styl_login, styl_ufo, styl_btn_one
}
