

api = {}



api.delete_clientToken = ({ effect, state }) ->
    localStorage.removeItem 'hornet_clientToken'

api.set_clientToken = ({ effect, state }) ->
    { clientToken } = effect.payload

    localStorage.setItem 'hornet_clientToken', clientToken


api.msg_server = ({ effect, state }) ->
    # c 'have'
    { type, payload } = effect.payload
    # c 'writing', type
    primus.write { type, payload }


api['primus_hotwire'] = ({ effect, state }) ->
    { type, payload } = effect.payload
    primus.write { type, payload }



# arq['build_selection'] = ({ desire, state }) ->
#     primus.write
#         type: 'build_selection'
#         payload: desire.payload


api.fetch_clientToken = ({ effect, store }) ->
    'fetching clientToken'
    clientToken = localStorage.getItem 'hornet_clientToken'
    c 'clientToken', clientToken
    store.dispatch
        type: 'res_fetch_clientToken'
        payload: { clientToken }


api['init_primus'] = ({ effect, store }) ->
    c 'initialising primus', store
    primus.on 'data', (data) ->
        c 'primus received data', data
        store.dispatch
            type: 'primus:data'
            payload: { data }

    setInterval =>
        primus.write
            type: 'polling'
    , 2000


exports.default = api
