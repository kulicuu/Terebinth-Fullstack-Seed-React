


api = {}


# api['logout'] =

api['send_a_message'] = ({ state, action }) ->
    { spark_id, token } = action.payload
    { message } = action.payload.data.payload
    state = state.setIn ['effects', shortid()],
        type: 'send_a_message'
        payload: { message, spark_id, token }

    state


exports.default = api
