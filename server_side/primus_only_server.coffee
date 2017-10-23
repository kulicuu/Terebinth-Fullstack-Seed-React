

http = require 'http'
Primus = require 'primus'
cookie_parser = require 'cookie-parser'


hornet_data = do ->
    cookie_parser_secret = 'astenhu093gp.0e9ce'
    cookies = cookie_parser cookie_parser_secret
    cookie_parser_secret: cookie_parser_secret
    cookies: cookies
    public_dir: path.resolve('..', 'hornet', 'public')
    index_path: '/dev_index.html'
    static_port: 2223


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


opts_hornet_primus =
    transformer: 'websockets'


express_session = require 'express-session'
connect_redis = require 'connect-redis'
Redis_Store = connect_redis express_session


hornet_redis_store_opts = {}
hornet_redis_store = new Redis_Store(hornet_redis_store_opts)

primus_only_server = http.createServer()


hornet_primus = new Primus(primus_only_server, opts_hornet_primus)


hornet_primus.use 'cookies', hornet_data.cookies
hornet_primus.use 'session', primus_session, { store: hornet_redis_store }
hornet_primus.save path.join(hornet_data.public_dir, '/js' , '/primus.js')


primus_port = 2224


primus_only_server.listen primus_port, ->
    require("./'stateless'_primus_effect.coffee") { hornet_primus }
    c "#{color.green('Primus server listenening on port ', on)} #{color.cyan(primus_port, on)}"
