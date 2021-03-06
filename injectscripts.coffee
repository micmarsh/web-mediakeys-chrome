correctLocation = ->
    LOCATION = window.location.hostname
    VALID_LOCATIONS = [
        'grooveshark.com'
        'www.grooveshark.com'
        'rdio.com'
        'www.rdio.com'
        'youtube.com'
        'www.youtube.com'
    ]
    return LOCATION in VALID_LOCATIONS

unless correctLocation()
    return


injectScript = (url) ->
    script = document.createElement 'script'
    script.src = url
    (document.head or document.documentElement).appendChild script

injected = false;

injectAllScripts = ->
    unless injected
        for fileName in ['controller', 'socketinterface']
            injectScript chrome.extension.getURL "javascripts/#{fileName}.js" +
            "?nocache=#{new Date().getTime()}"
        injected = true

window.onload = injectAllScripts
setTimeout injectAllScripts, 5000
#rdio doesn't like to fire onload events, so trick it