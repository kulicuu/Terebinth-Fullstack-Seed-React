local raw = ARGV[1]
local payload = cjson.decode(raw)

local clientToken = payload['clientToken']


local hornetId = redis.call('get', clientToken)

if hornetId == false then
    local payload = {}
    payload['status'] = "UFO"
    return cjson.encode(payload)
else
    local hornetTable = {}
    local hornetRayy = redis.call('hgetall', hornetId)
    hornetTable['email'] = hornetRayy[6]
    hornetTable['dateCreated'] = hornetRayy[8]
    hornetTable['lastLogin'] = hornetRayy[10]
    hornetTable['profileCompletion'] = hornetRayy[12]


    local payload = {}

    payload.status = "OkClear"
    payload.hornet = hornetTable


    return cjson.encode(payload)

end
