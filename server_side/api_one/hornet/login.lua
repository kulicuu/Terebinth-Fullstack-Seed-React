

local function hgetall(hash_key)
    local flat_map = redis.call('HGETALL', hash_key)
    local result = {}
    for i = 1, #flat_map, 2 do
        result[flat_map[i]] = flat_map[i + 1]
    end
    return result
end




local clientToken = ARGV[2]
local hornetId = ARGV[1]

local check_five = redis.call('hset', hornetId, 'clientToken', clientToken)
local hornetRayy = redis.call('hgetall', hornetId)

-- local hornet = hgetall(hornetId)

local hornetTable = {}
hornetTable['email'] = hornetRayy['6']
hornetTable['dateCreated'] = hornetRayy[8]
hornetTable['lastLogin'] = hornetRayy[10]
hornetTable['profileCompletion'] = hornetRayy[12]
hornetTable['username'] = hornetRayy[16]
hornetTable['user_realName'] = hornetRayy[18]
hornetTable['user_location'] = hornetRayy[20]



local call_one = redis.call('set', clientToken, hornetId)
local call_two = redis.call('expire', clientToken, 2400)






return cjson.encode(hornetTable)
-- return cjson.encode(hornetRayy)
-- return cjson.encode({hornetRayy})
