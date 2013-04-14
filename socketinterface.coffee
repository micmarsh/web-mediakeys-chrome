SOCKET_ORIGIN = 'http://localhost:3000'

allExist = (dependencies) ->
    dependencies.reduce (exists, dep) ->
        exists and !!window[dep]
    , true

waitFor = (dependencies, callback) ->
    do waitToSetup  = ->
        unless allExist dependencies
            console.log 'waiting!'
            setTimeout waitToSetup, 500
        else
            callback()

createButtonBinding = (keys, button) ->
    (data) -> keys[button]()

setup = (keys, io) ->
    socket = io.connect SOCKET_ORIGIN
    buttons = ['play', 'back', 'forward']

    for button in buttons
        socket.on button, createButtonBinding(keys, button)

waitFor ['io', 'Mediakeys'], ->
    setup Mediakeys, io
