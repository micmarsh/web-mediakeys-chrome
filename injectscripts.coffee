correctLocation = ->
    LOCATION = window.location.hostname
    VALID_LOCATIONS = [
        'grooveshark.com'
        'www.grooveshark.com'
        'rdio.com'
        'www.rdio.com'
    ]
    return LOCATION in VALID_LOCATIONS

unless correctLocation()
    return

window.onload = ->
    SOCKET_IO = 'http://localhost:3000/socket.io/socket.io.js'
    injectScript = (url) ->
        script = document.createElement 'script'
        script.src = url
        (document.head or document.documentElement).appendChild script

    injectScript SOCKET_IO
    for fileName in ['controller', 'socketinterface']
        injectScript chrome.extension.getURL "javascripts/#{fileName}.js"