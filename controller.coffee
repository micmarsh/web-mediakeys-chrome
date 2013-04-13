
values = (object) ->
    Object.keys(object).map (key) -> object[key]

getElement = (selector) ->
    document.getElementById(selector) or
    document.getElementsByClassName(selector)[0]

pageHasAllButtons = (page) ->
    return values(page).reduce (boolean, elementName) ->
        alert elementName
        alert getElement(elementName)
        boolean and Boolean getElement elementName
    , true


window.onload = ->
    LOCATION = window.location.hostname

    alert LOCATION

    groovesharkElements =
        play: 'play-pause'
        forward: 'play-next'
        back: 'play-prev'
    rdioElements =
        play:  'play_pause'
        forward: 'next'
        back: 'prev'

    elements =
        'grooveshark.com': groovesharkElements
        'www.grooveshark.com': groovesharkElements
        'rdio.com': rdioElements
        'www.rdio.com': rdioElements

    alert JSON.stringify elements

    unless pageHasAllButtons elements[LOCATION]
        return

    alert 'woot did not abort'

    #TODO: everythin loads in grooveshark but may not actually bind to anything,
    #nothing loads automatically in rdio but things are definitely bound to where
    #they need to be

    fireEvent = (element, event) -> console.log element#TODO: study that dude's function and write a legit one here

    click = (element) -> fireEvent(element, 'click')

    #TODO: functionality needed: grabbing dom elements (may be built into dude's fireEvent function,
        #but if not, simple enough, just need to confirm youtube's elements use ids as well)

    Mediakeys = {}

    findDOMelements = (domain) ->
        DOMelements = {}
        for mediaKey, domID of elements[domain]
            DOMelements[mediaKey] = getElement domID
        return DOMelements

    bindKeyFunctions = (DOMelements) ->
        for mediaKey, domElement of DOMelements
            Mediakeys[mediaKey] = -> click(domElement)

    Mediakeys.init = (domain) ->
        DOMelements = findDOMelements domain
        bindKeyFunctions DOMelements
        return Mediakeys

    window.Mediakeys = Mediakeys.init LOCATION



