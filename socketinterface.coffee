SOCKET_ORIGIN = 'ws://localhost:8889/'

allExist = (dependencies) ->
    dependencies.reduce (exists, dep) ->
        exists and !!window[dep]
    , true

waitFor = (dependencies, callback) ->
    do waitToSetup = ->
        unless allExist dependencies
            console.log 'waiting!'
            setTimeout waitToSetup, 500
        else
            callback()

setup = (keys) ->
    socket = new WebSocket SOCKET_ORIGIN
    socket.onmessage = (event) ->
        Mediakeys[event.data]()

waitFor ['Mediakeys'], ->
    setup Mediakeys

