





api = {}
api = fp.assign api, require('./hornet/register').default


















keys_api = _.keys api
gate = ({ type, payload, spark }) ->
    if _.includes(keys_api, type)
        api[type] { spark, payload }
    else
        c "#{color.yellow('No Op on type:', on)} #{color.cyan(type, on)}"




exports.default = gate
