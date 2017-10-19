




return 47

-- local hornet = cjson.decode(ARGV[1])


-- local payload = ARGV[1]
-- local hornet = cjson.decode(payload)
--
--
-- local keys = {}
-- local vals = {}
--
-- local idx = 0

-- for k, v in pairs(hornet) do
--     keys[idx] = k
--     vals[idx] = v
--     idx = idx + 1
-- end

-- local clientToken = hornet['clientToken']
-- local hornetId = hornet['hornetId']
-- local email = hornet['email']
-- local dateCreated = hornet['dateCreated']
-- local lastLogin = hornet['lastLogin']
-- local profileCompletion = hornet['profileCompletion']
-- local hash = hornet['hash']


-- redis.call('hmset', hornet['hornetId'], 'clientToken', clientToken, 'hornetId', hornetId, 'email', email, 'dateCreated', dateCreated, 'lastLogin', lastLogin, 'profileCompletion', profileCompletion, 'hash', hash)


-- redis.call('hset', 'hornets_emails', email, hornetId)
--
-- redis.call('set', clientToken, hornetId)
-- redis.call('expire', clientToken, 120)




-- return cjson.encode({"Ok"})
