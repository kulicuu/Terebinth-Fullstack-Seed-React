

global.flow = require 'async'
global.Bluebird = require 'bluebird'



global.c = console.log.bind console
global.color = require 'bash-color'

global.j = ( msg0, msg1 ) -> c "#{color.red(msg0, on)}  :  #{color.cyan(msg1, on)}"
global.i = ( msg0, msg1 ) -> c "#{color.cyan(msg0, on)} :   #{color.green(msg1, on)}"



global._ = require 'lodash'
global.fp = require 'lodash/fp'
global.fs = Bluebird.promisifyAll require('fs')

uuid = require 'node-uuid'
global.v4 = uuid.v4.bind uuid
global.path = require 'path'
global.Imm = require 'immutable'
global.shortid = require 'shortid'



Redis = require 'redis'

Bluebird.promisifyAll(Redis.RedisClient.prototype)
Bluebird.promisifyAll(Redis.Multi.prototype)

global.redis = Redis.createClient()
