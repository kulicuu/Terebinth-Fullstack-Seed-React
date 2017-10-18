

require './globals.coffee'

c "#{color.green('Starting stateful dev-server.', on)}"



dev_server = ({ env, cs }) ->

    c = console.log.bind console
    _ = require 'lodash'
    express = require 'express'
    cookie_parser = require 'cookie-parser'
    color = require 'bash-color'
    path = require 'path'
    fs = require 'fs'
    http = require 'http'
    Primus = require 'primus'


    app_one_arq = do ->
        cookie_parser_secret = 'astenhu093gp.0e9ce'
        cookies = cookie_parser cookie_parser_secret
        cookie_parser_secret: cookie_parser_secret
        cookies: cookies
        public_dir: path.resolve('..', 'app_one', 'public')
        index_path: '/dev_index.html'
        port: 2223
        primus_opts:
            transformer: 'websockets'


    express_session = require 'express-session'
    connect_redis = require 'connect-redis'
    Redis_Store = connect_redis express_session

    app_one_redis_store_opts = {}
    app_one_redis_store = new Redis_Store(app_one_redis_store_opts)


    primus_session = (options) ->
        key = options.key or 'connect.sid'
        store = options.store
        primus = @
        if not(store)
            message = 'Session middleware configuration failed due to missing store option.'
            throw new Error(message)
        (req, res, next) ->
            sid = req.signedCookies[key]
            req.session = {}
            if not(sid) then return next()
            store.get sid, (err, session) ->
                if err
                    primus.emit 'log', 'error', err
                    return next()
                if session then req.session = session
                next()


    app_one = express()


    app_one.all '/', (req, res, next) ->
        c color.purple(req.url, on)
        res.sendFile path.join(app_one_arq.public_dir, app_one_arq.index_path)


    app_one.use express.static(app_one_arq.public_dir)


    app_one_server = http.createServer app_one


    opts_app_one_primus =
        transformer: 'websockets'


    app_one_primus = new Primus(app_one_server, app_one_arq.primus_opts)

    app_one_primus.use 'cookies', app_one_arq.cookies
    app_one_primus.use 'session', primus_session, { store: app_one_redis_store }
    app_one_primus.save path.join(app_one_arq.public_dir, '/js' , '/primus.js')


    # the_api = require('./app_one_layer_control/index').default



    require('./store/index.coffee') { env, app_one_primus }


    app_one_server.listen app_one_arq.port, ->
        c 'server on', app_one_arq.port


    # app_one_primus.on 'connection', (spark) ->
    #     # dispatch to concord if want state
    #     spark.on 'data', (data) ->
    #
    #         c data, 'data'

            # the_api
            #     type: data.type
            #     payload: data.payload
            #     spark: spark

                # spark.write
                #     type: 'lookup_resp'
                #     payload: the_api
                #         # prefix: data.payload.prefix_text
                #         opts:
                #             lookup_type: 'lookup_prefix_000'


require('./store/reincarnate.coffee') { dev_server }
