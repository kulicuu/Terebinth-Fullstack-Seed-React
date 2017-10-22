





local hornetId = ARGV[1]
local clientToken = ARGV[2]

local check_five = redis.call('hset', hornetId, 'clientToken', clientToken)
local hornetRayy = redis.call('hgetall', hornetId)

local hornetTable = {}
hornetTable['email'] = hornetRayy[6]
hornetTable['dateCreated'] = hornetRayy[8]
hornetTable['lastLogin'] = hornetRayy[10]



local call_one = redis.call('set', clientToken, hornetId)
local call_two = redis.call('expire', clientToken, 2400)







-- return cjson.encode({hornetTable})
return cjson.encode({hornetRayy})
