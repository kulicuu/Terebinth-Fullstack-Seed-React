

bcrypt = require 'bcrypt'


login_lua_sha = null
login_lua_blob = null


fs.readFile path.resolve(__dirname, 'login.lua'), 'utf8', (err, blob) ->
    if err
        c err
    else
        login_lua_blob = blob
        redis.script 'load', blob, (err1, sha) ->
            if err1
                c err1
            else
                login_lua_sha = sha


api = {}


api.loginGo = ({ payload, spark }) ->
    { email, pwd } = payload

    redis.hgetAsync 'hornets_emails', email
    .then (hornet_id) ->
        c 'hornet_id', hornet_id
        if hornet_id is null
            spark.write
                type: 'res_loginGo'
                payload:
                    status: 'notRecognised'
        else
            redis.hgetAsync hornet_id, 'hash'
            .then (hash) ->
                c 'hash', hash
                c 'pwd', pwd
                if hash is null
                    spark.write
                        type: 'res_loginGo'
                        payload: { status: 'server_error' }
                else
                    bcrypt.compare pwd, hash, (err, res2) ->
                        if err
                            c ' handle err', err
                        else
                            c 'res2', res2
                            if res2 is true
                                c 'handle case accepted.'
                                clientToken = v4()
                                redis.evalshaAsync login_lua_sha, 2, 'hornetId', hornet_id, 'clientToken', clientToken
                                .then (re3) ->
                                    hornet = JSON.parse(re3)
                                    redis.hsetAsync hornet_id, 'clientToken', clientToken

                                    # redis.setAsync clientToken, hornet_id
                                    # redis.expireAsync clientToken, 120

                                    c 'res', hornet
                                    spark.write
                                        type: 'res_loginGo'
                                        payload:
                                            status: 'okClear'
                                            payload: { hornet, clientToken }

                            else
                                c 'handle case rejected.'
                                spark.write
                                    type: 'res_loginGo'
                                    payload:
                                        status: 'rejected'
                                        payload: { hornet, clientToken }























exports.default = api
