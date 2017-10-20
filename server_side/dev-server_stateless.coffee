

require './globals.coffee'


c = console.log.bind console
_ = require 'lodash'
express = require 'express'
cookie_parser = require 'cookie-parser'
color = require 'bash-color'
path = require 'path'
fs = require 'fs'
http = require 'http'
Primus = require 'primus'


hornet_data = do ->
    cookie_parser_secret = 'astenhu093gp.0e9ce'
    cookies = cookie_parser cookie_parser_secret
    cookie_parser_secret: cookie_parser_secret
    cookies: cookies
    public_dir: path.resolve('..', 'hornet', 'public')
    index_path: '/dev_index.html'
    port: 2223
    primus_opts:
        transformer: 'websockets'


express_session = require 'express-session'
connect_redis = require 'connect-redis'
Redis_Store = connect_redis express_session

hornet_redis_store_opts = {}
hornet_redis_store = new Redis_Store(hornet_redis_store_opts)


# TODO Implementation details  of Primus-specific sessions.
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


hornet = express()


# This may not be necessary iwth the usage of static services.
hornet.all '/', (req, res, next) ->
    c color.purple(req.url, on)
    res.sendFile path.join(hornet_data.public_dir, hornet_data.index_path)


hornet.use express.static(hornet_data.public_dir)


hornet_server = http.createServer hornet


opts_hornet_primus =
    transformer: 'websockets'


hornet_primus = new Primus(hornet_server, hornet_data.primus_opts)

hornet_primus.use 'cookies', hornet_data.cookies
hornet_primus.use 'session', primus_session, { store: hornet_redis_store }
hornet_primus.save path.join(hornet_data.public_dir, '/js' , '/primus.js')





hornet_server.listen hornet_data.port, ->
    require("./'stateless'_primus_effect.coffee") { hornet_primus }
    c 'server on', hornet_data.port
