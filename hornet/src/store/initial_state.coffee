
# navi = null
# reloaded_navi = location.href.split('#')[1]
# c 'reloaded_navi', reloaded_navi
# if (reloaded_navi is undefined) or (reloaded_navi.length is 0)
#     navi = 'ufo'
# else
#     navi = reloaded_navi

exports.default =
    hornet:
        # jobs: Imm.Map({})

        mood_status: 'ufo'

        navi: 'ufo'

        effects : Imm.Map
            "#{shortid()}":
                type: 'fetch_clientToken'
            "#{shortid()}":
                type: 'init_primus'
