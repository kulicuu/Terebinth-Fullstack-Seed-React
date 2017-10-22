



nest_lua_sha = null


fs.readFile path.resolve(__dirname, './nest.lua'), 'utf8', (err, blob) ->
    c err, blob
    if err
        j 'err in lua register load', err
    else
        redis.script 'load', blob, (err1, sha) ->
            if err1
                j 'redis_err', err1
            else
                nest_lua_sha = sha





api = {}



api.get_nest = ({ payload, spark }) ->
    { clientToken } = payload
    redis.evalshaAsync nest_lua_sha, 1, 'clientToken', JSON.stringify({ clientToken })
    .then (re22) ->

        c 're22', re22
        spark.write
            type: 'res_get_nest'

            payload: re22



exports.default = api
