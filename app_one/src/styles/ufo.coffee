



styl_register = ->




styl_login = ->


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







module.exports = { styl_btn_two, styl_options_ctr, h3_top, styl_register, styl_login, styl_ufo, styl_btn_one }
