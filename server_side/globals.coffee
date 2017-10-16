

global.flow = require 'async'
global.Bluebird = require 'bluebird'
global.c = console.log.bind console
global._ = require 'lodash'
global.fp = require 'lodash/fp'
global.fs = Bluebird.promisifyAll require('fs')
global.color = require 'bash-color'
uuid = require 'node-uuid'
global.v4 = uuid.v4.bind uuid
global.path = require 'path'
global.Imm = require 'immutable'
global.shortid = require 'shortid'



Redis = require 'redis'

Bluebird.promisifyAll(Redis.RedisClient.prototype)
Bluebird.promisifyAll(Redis.Multi.prototype)

global.redis = Redis.createClient()
