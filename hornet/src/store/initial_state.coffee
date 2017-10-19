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
