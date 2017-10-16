




get_hive = ({ state }) ->
    lounger_sessions = state.get('lounger_sessions').toJS()
    hive = {}
    for k, sesh of lounger_sessions
        do (sesh) ->
            hive["#{sesh.safe_id}"] =
                username: sesh.username
    hive


api = {}


api['send_message'] = ({ state, dispatch, effect }) ->

    primus = state.get('helsinki_primus')
    # { token } = desire.payload
    # { input_field } = desire.payload.data.payload

    # c 'have an input field', input_field
    primus.write
        type: 'new_message'
        payload: desire.payload


api['request_orient'] = ({ state, dispatch, effect }) ->
    { token } = desire.payload
    { spark, username, safe_id } = state.getIn(['lounger_sessions', token]).toJS()
    chat_log = state.get('chat_log').toJS()
    hive = get_hive { state }
    spark.write
        type: 'orient:reply'
        payload:
            username: username
            safe_id: safe_id
            hive: hive
            chat_log: chat_log


exports.default = api
