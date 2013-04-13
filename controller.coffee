LOCATION = window.location.hostname

elements =
    'grooveshark.com':
        play: 'play-pause'
        forward: 'play-next'
        back: 'play-prev'
    'rdio.com':
        play:  'play_pause'
        forward: 'next'
        back: 'prev'

values = (object) ->
    Object.keys(object).map (key) -> object[key]

pageHasAllButtons = (pagename) ->
    currentPage = elements[pagename]
    return values(currentPage).reduce (boolean, elementName) ->
        boolean and Boolean document.getElementById(elementName)
    , true

unless pageHasAllButtons LOCATION
    return

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


