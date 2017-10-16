



api = {}


api['send_edited_message'] = ({ state, action }) ->
    { token } = action.payload
    sesh = state.getIn ['lounger_sessions', token]
    { input_value, item } = action.payload.data.payload
    # if item.safe_id is sesh.safe_id
        # c 'doing'
    # TODO: improve safety & security for this process
    chat_log = state.get 'chat_log'
    the_entry = chat_log.findEntry (msg, idx) ->
        if msg.message_id is item.message_id
            true
    our_idx = the_entry[0]
    our_element = the_entry[1]
    our_element.input_field = input_value
    our_element.content = input_value
    chat_log = chat_log.update our_idx, (msg_item) ->
        our_element
    state = state.set 'chat_log', chat_log
    state

api['change_username'] = ({ state, action }) ->
    { spark_id, token, data } = action.payload
    { username_input_field } = data.payload
    state = state.setIn ['lounger_sessions', token, 'username'], username_input_field
    state


api['send_message'] = ({ state, action }) ->
    { spark_id, token } = action.payload
    sesh = state.getIn(['lounger_sessions', token]).toJS()
    { session_metadata, safe_id, username } = sesh
    { input_field } = action.payload.data.payload
    api_900 =
        message_id: v4()
        input_field: input_field
        content: input_field
        timestamp: Date.now()
        safe_id: safe_id
    chat_log = state.get('chat_log')
    state  = state.set('chat_log', chat_log.push(api_900))
    state.setIn ['desires', shortid()],
        type: 'send_message'
        payload: api_900

api['request_orient'] = ({ state, action }) ->
    { spark_id, token } = action.payload
    state.setIn ['desires', shortid()],
        type: 'request_orient'
        payload: action.payload

api['do_login'] = ({ state, action }) ->
    { spark_id, token } = action.payload
    # spark = state.getIn(['lounger_sessions', token, 'spark'])
    { username_candide, password_candide } = action.payload.data.payload
    state = state.setIn ['desires', shortid()],
        type: 'do_login'
        payload: { username_candide, password_candide, spark_id, token }
    state


api['do_signup'] = ({ state, action }) ->
    { session_metadata, spark_id, data, token } = action.payload
    { type, payload } = data
    payload = assign payload, { session_metadata, spark_id, token }
    signup_attempt_entry =
        timestamp: Date.now()
        id: v4()
        payload: payload
    state = state.setIn ['desires', shortid()],
        type: 'do_signup'
        payload: 'payload'
    state

api['check_is_username_valid_and_avail'] = ({ state, action, data }) ->
    { session_metadata, spark_id, data, token } = action.payload
    { type, payload } = data
    todo = 'maintain some memory of ufos by ip and session'
    { username_candide } = data.payload
    state.setIn ['desires', shortid()],
        type: 'check_is_username_valid_and_avail'
        payload: { username_candide, session_metadata, spark_id }
    state


exports.default = api
