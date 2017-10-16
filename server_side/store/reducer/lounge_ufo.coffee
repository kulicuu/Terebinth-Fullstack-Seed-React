


elements = [
    "wood"
    "fire"
    "earth"
    "metal"
    "water"
]

colors = [
    "cobalt-blue"
    "stained-silver"
    "verdigris-copper"
    "gold-flakes"
    "titanium-white"
]

animals = [
    'rooster'
    'tanuki'
    'ratsnake'
    'mongoose'
    'falcon'
]




api = {}



verified_lounger = require('./verified_lounger.coffee')
keys_verified_lounger = _.keys verified_lounger


ufo = require('./lounge_ufo_api').default
keys_ufo = _.keys ufo


api['helsinki:spark:data'] = ({ state, action }) ->
    { session_metadata, spark_id, data, token } = action.payload
    { type, payload } = data

    if includes(keys_ufo, type)
        state = ufo[type] { state, action, data, token }
    else if includes(keys_verified_lounger, type)
        user = state.getIn(['lounger_sessions', token, 'user'])
        if user.toJS?
            if user.toJS().role is 'lounger'
                state = verified_lounger[type] { cs, state, action, data, token }
    else
        c 'noop in spark : data in reducer with action.type', action.type
    state


api['helsinki:primus:spark'] = ({ state, action }) ->
    { spark, session_metadata } = action.payload
    { signedCookies, cookies, session, token } = session_metadata
    token = signedCookies['connect.sid']
    if state.hasIn(['lounger_sessions', token]) isnt true
        master_session = Imm.Map
            spark: spark
            session_metadata: session_metadata
            token: token
            safe_id: v4()
            username: "#{elements[Math.floor(Math.random() * 5)]} #{colors[Math.floor(Math.random() * 5)]} #{animals[Math.floor(Math.random() * 5)]}"
        state = state.setIn(['lounger_sessions', token], master_session)
    else
        state = state.setIn(['lounger_sessions', token, 'spark'], spark)
    state

module.exports = api
