






local raw = ARGV[1]
local payload = cjson.decode(raw)

local clientToken = payload['clientToken']



-- return clientToken


local hornetId = redis.call('get', clientToken)

-- return hornetId

if hornetId == nil then
    payload = {}
    payload['status'] = "It's not so good."
    return cjson.encode(payload)
    -- return

else
    -- return hornetId
    local hornetTable = {}
    local hornetRayy = redis.call('hgetall', hornetId)
    hornetTable['email'] = hornetRayy[6]
    hornetTable['dateCreated'] = hornetRayy[8]
    hornetTable['lastLogin'] = hornetRayy[10]
    hornetTable['profileCompletion'] = hornetRayy[12]

    return cjson.encode(hornetTable)


end
