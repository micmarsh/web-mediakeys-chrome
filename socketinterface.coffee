window.SOCKET_ORIGIN = 'http://localhost:3000'


allExist = (dependencies) ->
    dependencies.reduce (exists, dep) ->
        exists and !!window[dep]
    , true

waitFor = (dependencies) ->
    return waitToSetup = ->
        unless allExist dependencies
            console.log 'waiting!'
            setTimeout waitToSetup, 500
        else
            setup Mediakeys, io

setup = (keys) ->
    buttons = ['play', 'back', 'forward']
    for button in buttons


waitFor(['io', 'Mediakeys'])()