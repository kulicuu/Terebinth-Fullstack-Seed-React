

api = {}



api.msg_server = ({ effect, state }) ->
    c 'have'
    { type, payload } = effect.payload
    c 'writing', type
    primus.write { type, payload }


api['primus_hotwire'] = ({ effect, state }) ->
    { type, payload } = effect.payload
    primus.write { type, payload }



# arq['build_selection'] = ({ desire, state }) ->
#     primus.write
#         type: 'build_selection'
#         payload: desire.payload


api['init_primus'] = ({ effect, store }) ->
    c 'initialising primus', store
    primus.on 'data', (data) ->
        c 'primus received data', data
        store.dispatch
            type: 'primus:data'
            payload: { data }

    setInterval =>
        primus.write
            type: 'request_orient'
    , 1000


exports.default = api
