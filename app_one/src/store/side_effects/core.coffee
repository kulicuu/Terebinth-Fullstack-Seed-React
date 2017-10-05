

arq = {}


arq['primus_hotwire'] = ({ desire, state }) ->
    { type, payload } = desire.payload
    primus.write { type, payload }



# arq['build_selection'] = ({ desire, state }) ->
#     primus.write
#         type: 'build_selection'
#         payload: desire.payload


arq['init_primus'] = ({ desire, store }) ->
    c 'initialising'
    primus.on 'data', (data) ->
        c 'walla', data
        store.dispatch
            type: 'primus:data'
            payload: { data }

    # setInterval =>
    #     primus.write
    #         type: 'request_orient'
    # , 300


exports.default = arq
