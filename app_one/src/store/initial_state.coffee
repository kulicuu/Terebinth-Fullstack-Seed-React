exports.default =
    hornet:
        # jobs: Imm.Map({})
        
        effects : Imm.Map
            "#{shortid()}":
                type: 'init_primus'
