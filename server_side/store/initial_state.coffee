

state_cache_reducer = ({ state_cache }) ->
    # TODO
    {}

log_cache = Imm.List []

module.exports = ({
    state_cache,
    app_one_primus }) ->

    state = state_cache_reducer { state_cache }

    primary_state =
        log_cache: log_cache

        effects: Imm.Map({})

        app_one_primus: app_one_primus # TODO rename hornet primus

        ufo_sessions: Imm.Map({})
        hornet: Imm.Map({})
        hornet_sessions: Imm.Map({})

    state = fp.assign state, primary_state

    state = Imm.fromJS state

    state.setIn ['effects', shortid()], { type: 'primus:init_all_the_primus' }

    # return state  # implicitly
