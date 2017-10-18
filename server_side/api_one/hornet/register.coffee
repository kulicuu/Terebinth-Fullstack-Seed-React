



api = {}





respond_check_avail = ({ status, spark }) ->
    spark.write
        type: 'res_register_check_avail'
        payload: { status }


api.register_check_avail = ({ payload, spark }) ->
    { candide } = payload
    redis.hgetAsync 'hornets_emails', candide
    .then (re) ->
        if re is null
            respond_check_avail { spark, status: 'okGood' }
        else
            respond_check_avail { spark, status: 'noTaken' }












exports.default = api
