the_api = require('./api_one/hornet.coffee').default



module.exports = ({ hornet_primus }) ->

    hornet_primus.on 'connection', (spark) ->
        # dispatch to concord if want state
        c spark, 'spark'
        c spark.headers.ufo_token, 'spark.headers.ufo_token'
        ufo_token = v4()
        spark.headers.ufo_token = ufo_token
        spark.on 'data', (data) ->
            c data, 'data'
            the_api
                type: data.type
                payload: data.payload
                spark: spark
