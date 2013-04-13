elements =
    'grooveshark.com':
        play: 'play-pause'
        forward: 'play-next'
        back: 'play-prev'
        #window.location.hostname
    'rdio.com':
        play:  'play_pause'
        forward: 'next'
        back: 'prev'

#TODO: a quick check for the right page a function that loads up (this should not be a content
    #script, at least the vast majority of it's functions should not be) attempts to pull
#up a "play" button

fireEvent = (element, event) -> console.log element#TODO: study that dude's function and write a legit one here

click = (element) -> fireEvent(element, 'click')

#TODO: functionality needed: grabbing dom elements (may be built into dude's fireEvent function,
    #but if not, simple enough, just need to confirm youtube's elements use ids as well)

Mediakeys = {}

findDOMelements = (domain) ->
    DOMelements = {}
    for mediaKey, domID of elements[domain]
        DOMelements[mediaKey] = document.getElementById(domID)
    return DOMelements

bindKeyFunctions = (DOMelements) ->
    for mediaKey, domElement of DOMelements
        Mediakeys[mediaKey] = -> click(domElement)

Mediakeys.init = (domain) ->
    DOMelements = findDOMelements domain
    bindKeyFunctions DOMelements

window.Mediakeys = Mediakeys


