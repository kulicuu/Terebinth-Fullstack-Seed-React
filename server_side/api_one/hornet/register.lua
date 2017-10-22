local payload = ARGV[1]
local hornet = cjson.decode(payload)


local keys = {}
local vals = {}

local idx = 0

for k, v in pairs(hornet) do
    keys[idx] = k
    vals[idx] = v
    idx = idx + 1
end

local clientToken = hornet['clientToken']
local hornetId = hornet['hornetId']
local email = hornet['email']
local dateCreated = hornet['dateCreated']
local lastLogin = hornet['lastLogin']
local profileCompletion = hornet['profileCompletion']
local hash = hornet['hash']
local username = hornet['username']
local user_realName = hornet['user_realName']
local user_location = hornet['user_location']


-- redis.call('hmset', hornet['hornetId'], 'clientToken', clientToken, 'hornetId', hornetId, 'email', email, 'dateCreated', dateCreated, 'lastLogin', lastLogin, 'profileCompletion', profileCompletion, 'hash', hash)


redis.call('hmset', hornetId, 'clientToken', clientToken, 'hornetId', hornetId, 'email', email, 'dateCreated', dateCreated, 'lastLogin', lastLogin, 'profileCompletion', profileCompletion, 'hash', hash, 'username', username, 'user_realName', user_realName, 'user_location', user_location)



local check_zero = redis.call('hset', 'hornets_emails', email, hornetId)

local check_one = redis.call('set', clientToken, hornetId)

-- return cjson.encode({ check_one, check_zero, clientToken, hornetId })

local check_two = redis.call('expire', clientToken, 2400)
--
--
--
--
return cjson.encode({"Ok"})
