

# This enables a restarting server to access state that persists on Redis in spite of
# process restarts.
# There is also a logging to Redis functionality, which would in a fuller
# implementation would implement a structured logging capability.

# This could be valuable during development enabling persistent state / config in spite of process restarts
# for code changes 

# c = console.log.bind console
# Redis = require 'redis'
# redis = Redis.createClient()

logging_func_f = ({ env, dev_server }) ->
    c 'Making structured logging function.'
    cs = ( stuff ) ->
        redis.lpush 'log_cache', JSON.stringify(stuff)
    dev_server { cs, env }

get_state_cache = ({ logging_func_f, dev_server }) ->
    c "Getting state cache."
    redis.hgetall 'env', (err, env) ->
        if err then c err else
            logging_func_f { env, dev_server }

module.exports = ({ dev_server }) ->
    get_state_cache { logging_func_f, dev_server }
