SOCKET_ORIGIN = 'http://localhost:3000'

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

createButtonBinding = (keys, button) ->
    (data) -> keys[button]()

saveGivenID = ({id}) ->
    #TODO: this, obviously
    alert "You got an id!\n#{id}"
    window.weGotID = id

setup = (keys, io) ->
    socket = io.connect SOCKET_ORIGIN
    buttons = ['play', 'back', 'forward']
    #TODO: this doesn't appear to be connecting properly,
    #wtf
    socket.emit 'generateID', {clientType: 'player'}
    for button in buttons
        socket.on button, createButtonBinding(keys, button)
    socket.on 'idResponse', saveGivenID

waitFor ['io', 'Mediakeys'], ->
    setup Mediakeys, io

    window.socketTest = socketTest = do (io)->
        client = io.connect SOCKET_ORIGIN
        buttons = ['play', 'back', 'forward']
        tester = { }
        id = null

        tester.connectID = (ID) ->
            id = ID
            client.emit 'connectedID', {id, clientType: 'buttons'}


        for button in buttons
            tester[button] = -> client.emit button, {id}
        return tester

