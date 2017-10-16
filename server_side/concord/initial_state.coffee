

state_cache_reducer = ({ state_cache }) ->
    # TODO
    {}

log_cache = Imm.List []


module.exports = ({
    cs, state_cache,
    helsinki_primus,
    redis
}) ->

    state = state_cache_reducer { state_cache }

    primary_state =
        log_cache: log_cache
        effects: Imm.Map({})
        ufo_sessions: Imm.Map({})
        lounger_sessions: Imm.Map({})

        helsinki_primus: helsinki_primus

        chat_log: Imm.List([])

    state = assign state, primary_state

    state = Imm.fromJS state

    state.setIn ['effects', shortid()], { type: 'primus:init_all_the_primus' }

    # return state  # implicitly
