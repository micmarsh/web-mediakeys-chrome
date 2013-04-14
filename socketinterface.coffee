window.SOCKET_ORIGIN = 'http://localhost:3000'
allExist = (dependencies) ->
    dependencies.reduce (exists, dep) ->
        exists and !!window[dep]
    , true
waitFor = (dependencies, callback) ->
    do waitToSetup ->
        unless allExist dependencies
            console.log 'waiting!'
            setTimeout waitToSetup, 500
        else
            callback()
setup = (keys) ->
    buttons = ['play', 'back', 'forward']

waitFor ['io', 'Mediakeys'], ->
    setup Mediakeys, io
