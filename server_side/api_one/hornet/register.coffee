

bcrypt = require 'bcrypt'

register_lua_sha = null
register_lua_blob = null

fs.readFile path.resolve(__dirname, './register.lua'), 'utf8', (err, blob) ->
    c err, blob
    if err
        j 'err in lua register load', err
    else
        register_lua_blob = blob
        redis.script 'load', blob, (err1, sha) ->
            if err1
                j 'redis err', err1
            else
                register_lua_sha = sha



api = {}



hornet_f = ({ email, hash }) ->
    email: email
    dateCreated: Date.now()
    lastLogin: Date.now()
    profileCompletion: "new_hornet"
    hash: hash


# lua variant
api.registerGo = ({ payload, spark }) ->
    { email, pwd } = payload
    hornet_id = v4()
    bcrypt.genSalt 10, (err, salt) ->
        if err
            c "#{color.red('handle err', on)}"
        else
            c 'salt', salt
            bcrypt.hash pwd, salt, (err2, hash) ->
                if err2
                    c "#{color.red('handle error', on)}"
                else
                    hornet = hornet_f { email, hash }
                    redis.evalshaAsync register_lua_sha, 0
                    .then (re3) ->
                        i 'lua returns', re3
                    # redis.hmsetAsync hornet_id, hornet
                    # .then (re2) ->
                    #     spark.write
                    #         type: 'res_registerGo'
                    #         payload:
                    #             status: 'okGood'
                    #             clientToken: 'placeholder'
                    #             hornet: hornet


# naive alpha
api.naive_registerGo = ({ payload, spark }) ->
    { email, pwd } = payload

    hornet_id = v4()

    bcrypt.genSalt 10, (err, salt) ->
        if err
            c "#{color.red('handle err', on)}"
        else
            c 'salt', salt
            bcrypt.hash pwd, salt, (err2, hash) ->
                if err2
                    c "#{color.red('handle error', on)}"
                else
                    hornet = hornet_f { email, hash }
                    redis.hmsetAsync hornet_id, hornet
                    .then (re2) ->
                        spark.write
                            type: 'res_registerGo'
                            payload:
                                status: 'okGood'
                                clientToken: 'placeholder'
                                hornet: hornet




    redis.hsetAsync 'hornets_emails', email, hornet_id
    .then (re0) ->
        c "#{color.blue('re0', on)} #{color.purple(re0, on)}"




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
