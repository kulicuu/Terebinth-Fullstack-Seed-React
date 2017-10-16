


arq = {}


arq['logout'] =

arq['send_a_message'] = ({ cs, state, action }) ->
    { spark_id, token } = action.payload
    { message } = action.payload.data.payload
    state = state.setIn ['desires', shortid()],
        type: 'send_a_message'
        payload: { message, spark_id, token }

    state


exports.default = arq
