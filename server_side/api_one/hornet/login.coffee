

bcrypt = require 'bcrypt'

api = {}





api.loginGo = ({ payload, spark }) ->
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
