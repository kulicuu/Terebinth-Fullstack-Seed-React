

styl_btn_registerGo = ->
    cursor: 'pointer'
    width: .44 * ww
    height: .24 * wh
    backgroundColor: 'lightgrey'
    color: 'darkslategrey'
    fontFamily: 'sans'
    fontSize: .032 * wh
    margin: .01 * wh



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
    height: .032 * wh
    textAlign: 'center'
    fontSize: .020 * wh
    color: 'gold'
    backgroundColor: 'darkslategrey'
    margin: .01 * wh


styl_email_ipt = ->
    margin: .004 * wh
    color: 'gold'
    width: .58 * ww
    height: .04 * wh
    textAlign: 'center'
    fontSize: .024 * wh
    backgroundColor: 'darkslategrey'

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
    fontSize: .034 * wh
    marginBottom: .002 * wh
    marginTop: .002 * wh
    cursor: 'pointer'
    color: 'darkkhaki'







module.exports = {
    styl_email_ipt
    , styl_btn_registerGo
    , styl_btn_return
    , styl_register_ctr
    , styl_register
    , styl_pwd_ipt
    , styl_btn_two, styl_options_ctr, h3_top, styl_register, styl_login, styl_ufo, styl_btn_one
}
