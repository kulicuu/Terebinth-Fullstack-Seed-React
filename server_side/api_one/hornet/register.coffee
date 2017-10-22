

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
    clientToken: v4()
    hornetId: v4()
    email: email
    dateCreated: Date.now()
    lastLogin: Date.now()
    profileCompletion: "new_hornet"
    hash: hash
    username: ""
    user_realName: ""
    user_location: ""
    

hornet_safe_f = ({ hornet }) ->
    fp.omit ['hash', 'hornetId' ], hornet


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
                c 'hashi in register', hash
                if err2
                    c "#{color.red('handle error', on)}"
                else
                    hornet = hornet_f { email, hash }
                    hornet_safe = hornet_safe_f { hornet }
                    c 'hornet in register before lua', hornet
                    redis.evalshaAsync register_lua_sha, 1, 'hornet', JSON.stringify(hornet)
                    .then (re3) ->

                        res = JSON.parse re3
                        c 'res on register ', res
                        if res[0] is "Ok"
                            spark.write
                                type: 'res_registerGo'
                                payload:
                                    status: 'okGood'
                                    clientToken : hornet.clientToken
                                    hornet: hornet_safe
                        else
                            c "handle bad password etc messaging."







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
