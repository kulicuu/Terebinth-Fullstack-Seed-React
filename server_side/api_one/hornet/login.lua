





local hornetId = ARGV[1]



local hornetRayy = redis.call('hgetall', hornetId)
local clientToken = hornetRayy[2]
local hornetId = hornetRayy[4]


local hornetTable = {}
hornetTable['clientToken'] = hornetRayy[2]
hornetTable['hornetId'] = hornetRayy[4]
hornetTable['email'] = hornetRayy[6]
hornetTable['dateCreated'] = hornetRayy[8]
hornetTable['lastLogin'] = hornetRayy[10]



redis.call('set', clientToken, hornetId)
redis.call('expire', clientToken, 2400)







return cjson.encode({hornetTable[1]})
