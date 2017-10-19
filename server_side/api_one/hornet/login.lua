





local hornetId = ARGV[1]

local hornetRayy = redis.call('hgetall', hornetId)
local hornetTable = {}
-- hornetTable['clientToken'] = hornetRayy[2]
-- hornetTable['hornetId'] = hornetRayy[4]
hornetTable['email'] = hornetRayy[6]
hornetTable['dateCreated'] = hornetRayy[8]
hornetTable['lastLogin'] = hornetRayy[10]
hornetTable['profileCompletion'] = hornetRayy[12]











return cjson.encode(hornetTable)
