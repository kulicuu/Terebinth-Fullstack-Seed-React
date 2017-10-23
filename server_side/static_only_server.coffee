

express = require 'express'
cookie_parser = require 'cookie-parser'


hornet_data = do ->
    cookie_parser_secret = 'astenhu093gp.0e9ce'
    cookies = cookie_parser cookie_parser_secret
    cookie_parser_secret: cookie_parser_secret
    cookies: cookies
    public_dir: path.resolve('..', 'hornet', 'public')
    index_path: '/dev_index.html'
    static_port: 2223


http = require 'http'







hornet_static_server = express()


hornet_static_server.all '/', (req, res, next) ->
    c color.purple(req.url, on)
    res.sendFile path.join(hornet_data.public_dir, hornet_data.index_path)


hornet_static_server.use express.static(hornet_data.public_dir)


hornet_static_port = 2223

hornet_static_server.listen hornet_static_port, ->
    c "#{color.blue('Static server listening on port', on)} #{color.white(hornet_static_port, on)}"
