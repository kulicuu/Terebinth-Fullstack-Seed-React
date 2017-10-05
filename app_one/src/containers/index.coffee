

root_el = document.getElementById 'root'


Provider = rc require('react-redux').Provider


store = require('../store/create.coffee')


nexus = rc require('./nexus.coffee').default


root_component = rr
    render: ->
        { ww, wh } = @props
        Provider
            store: store
            nexus
                ww: .9893 * ww
                wh: wh


set_and_render = ->
    { width, height } = root_el.getBoundingClientRect()
    React_DOM.render root_component({ ww: width, wh: height}), root_el


window.onload = ->
    set_and_render()
    window.onresize = debounce(set_and_render, 100, false)
