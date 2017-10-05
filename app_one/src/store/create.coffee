

{
    applyMiddleware, compose, createStore
} = require 'redux'
{ combineReducers } = require 'redux-immutable'
thunk = require('redux-thunk').default
middleware = thunk


lookup = require('./reducers/lookup.coffee').default

reducers = { lookup }

initial_state = require('./initial_state.coffee').default

imm_initial_state = Imm.fromJS(initial_state)

store = createStore(combineReducers(reducers), imm_initial_state, compose(applyMiddleware(middleware)))

side_effects = require('./side_effects.coffee').default { store }


side_effect_trigger_f = ({ store }) ->
    ->
        state_js = store.getState().toJS()
        side_effects { state_js }

set = side_effect_trigger_f { store }
store.subscribe set

state_js = imm_initial_state.toJS()
side_effects { state_js }


module.exports = store
