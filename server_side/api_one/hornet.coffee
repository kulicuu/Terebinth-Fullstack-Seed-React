

wakeup_lua_sha = null
wakeup_lua_blob = null


fs.readFile path.resolve(__dirname, 'hornet', 'wakeup.lua'), 'utf8', (err, blob) ->
    if err
        c err
    else
        wakeup_lua_blob = blob
        redis.script 'load', blob, (err1, sha) ->
            if err1
                c err1
            else
                wakeup_lua_sha = sha



api = {}


api = fp.assign api, require('./hornet/register').default
api = fp.assign api, require('./hornet/login').default







api.wakeup_refresh_w_clientToken = ({ payload, spark }) ->

    { clientToken } = payload

    redis.evalshaAsync wakeup_lua_sha, 1, 'clientToken', JSON.stringify({clientToken})
    .then (re34) ->
        c "#{color.cyan('re34', on)} #{color.green(re34, on)}"
        c re34
        res = JSON.parse(re34)
        if res.status is "UFO"
            c 'nope'
        else if res.status is "OkClear"
            spark.write
                type: 'res_wakeup'
                payload:
                    status: "OkClear"
                    clientToken: clientToken
                    hornet: JSON.parse(re34)
    .error (lua_err) ->
        j 'lua err', lua_err
        c lua_err

    # we should be able to fetch a hornet based on this which means
    # it's isomorphic with a user_id, should it just be the user_id ?
    # It shouldn't be specific to the server, because same client might get
    # different server behind load balancer.  At this point we can do a
    # They should be different because the user-id won't change but the token
    # should be changed all the time.
    # When a token is generated it needs to key a hash which is valued at that id
    # at the same time the hornet-main-hash needs to have active-token-set to that token
    # the old token needs to be deleted from that same hash table. probably should just be
    # expiring keys.  Ready for Lua ?  Yes, I think so.










keys_api = _.keys api
gate = ({ type, payload, spark }) ->
    if _.includes(keys_api, type)
        api[type] { spark, payload }
    else
        c "#{color.yellow('No Op on type:', on)} #{color.cyan(type, on)}"




exports.default = gate
