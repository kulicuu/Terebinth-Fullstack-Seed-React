

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
                            c 'err', err
                        else
                            c 'res2', res2
                        if res2 is true
                            c 'handle case accepted.'

                            redis.evalshaAsync login_lua_sha, 1, 'hornetId', hornet_id
                            .then (re3) ->
                                c re3
                                hornet = JSON.parse(re3)
                                clientToken = hornet.clientToken
                                c 'res', hornet
                                spark.write
                                    type: 'res_loginGo'
                                    payload:
                                        status: 'okClear'
                                        payload: { hornet, clientToken }

                        else
                            c 'handle case rejected.'






api.loginGo_dep = ({ payload, spark }) ->
    { email, pwd } = payload



    c 'pwd', pwd



    redis.hgetAsync 'hornets_emails', email
    .then (hornet_id) ->
        if hornet_id is null
            spark.write
                type: 'res_loginGo'
                payload:
                    status: 'notRecognised'
        else
            redis.hgetallAsync hornet_id
            .then (hornet) ->
                c 'hornet', hornet
                if hornet is null
                    spark.write
                        type: 'res_loginGo'
                        payload: { status: 'server_error' }
                else
                    bcrypt.compare pwd, hornet.hash, (err, res2) ->
                        if err
                            c 'err', err
                        else
                            c 'res2', res2
                        if res2 is true
                            c 'truly'
                            clientToken = v4()
                            spark.write
                                type: 'res_loginGo'
                                payload:
                                    status: 'okClear'
                                    payload: { hornet, clientToken }
                        else
                            spark.write
                                type: 'res_loginGo'
                                payload: { status: 'noBadPassword' }





    # redis.hsetAsync 'hornets_emails', email, hornet_id
    # .then (re0) ->
    #     c "#{color.blue('re0', on)} #{color.purple(re0, on)}"



















exports.default = api
