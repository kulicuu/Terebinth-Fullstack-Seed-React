

bcrypt = require 'bcrypt'

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
            redis.hgetallAsync hornet_id
            .then (hornet) ->
                if hornet is null
                    spark.write
                        type: 'res_loginGo'
                        payload: { status: 'server_error' }
                else
                    bcrypt.compare pwd, hornet.hash, (err, res2) ->
                        if res2 is true
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
