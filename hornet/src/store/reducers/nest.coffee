










api = {}




incoming_api = {}



incoming_api.res_get_nest = ({ state, action, data }) ->
    parsed = JSON.parse data.payload
    nest = _.reduce parsed[0], (acc, v, idx) ->
        if (idx % 2) is 1
            acc = [].concat(acc, v)
            acc
        else
            acc
    , []
    c 'nest', nest
    state = state.set 'nest', Imm.List(nest)
    state



exports.incoming = incoming_api













exports.default = api
