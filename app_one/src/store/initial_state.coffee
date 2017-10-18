exports.default =
    hornet:
        # jobs: Imm.Map({})

        navi: 'register'

        effects : Imm.Map
            "#{shortid()}":
                type: 'init_primus'
