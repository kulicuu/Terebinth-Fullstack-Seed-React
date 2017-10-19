



local raw = ARGV[1]
local payload = cjson.decode(raw)
local clientToken = payload['clientToken']

local maybe_hornetId = redis.call('get', clientToken)



if maybe_hornetId == false then
    return 44
else
    -- means this hornet is real and allowed to look for the db of all hornets
    local hornet_email_id_rayy = redis.call('hgetall', 'hornets_emails')
    -- return cjson.encode({hornet_email_hash})

    -- counter = 0
    local table = {}


    for k, v in pairs(hornet_email_id_rayy) do
        local safe_hornet = {}
        local unsafe_hornet = redis.call('hgetall', v)
        -- safe_hornet['dateCreated'] = unsafe_hornet['dateCreated']
        -- safe_hornet['profileCompletion'] = unsafe_hornet['profileCompletion']
        -- safe_hornet['lastLogin'] = unsafe_hornet['lastLogin']
        table[k] = unsafe_hornet
    end

    return cjson.encode(table)

end
