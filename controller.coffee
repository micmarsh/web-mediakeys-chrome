DEBUG = no#lol no

#GOAL get shit to load and bind in both places. It does! except can't create
#window.Mediakeys from here. Perhaps inject this into page. Yeah, that could work

#possible ways to divide things up: a Mediakeys class that takes a document object,
#binds all the keys when initialized

#click and fireEvent should be part of this b/c premature optimization is bad

#class should "live" inside extension get a document object to pass into it

#probably a content script to check if page is relevant and pass message up, some
#script in extension to recieve message and build  mediakeys object, then pass it
#into something that handles socket action

`function fireEvent(e,t){var n=null,r,i,s,o,u,a={pointerX:0,pointerY:0,button:0,ctrlKey:false,altKey:false,shiftKey:false,metaKey:false,bubbles:true,cancelable:true},f=[["HTMLEvents",["load","unload","abort","error","select","change","submit","reset","focus","blur","resize","scroll"]],["MouseEvents",["click","dblclick","mousedown","mouseup","mouseover","mousemove","mouseout"]]];for(r=0,i=f.length;r<i;++r){for(s=0,o=f[r][1].length;s<o;++s){if(t===f[r][1][s]){n=f[r][0];r=i;s=o}}}if(arguments.length>2){if(typeof arguments[2]==="object"){change(a,arguments[2])}}if(n===null){throw new SyntaxError('Event type "'+t+'" is not implemented!')}if(document.createEvent){u=document.createEvent(n);if(n==="HTMLEvents"){u.initEvent(t,a.bubbles,a.cancalable)}else{u.initMouseEvent(t,a.bubbles,a.cancelable,document.defaultView,a.button,a.pointerX,a.pointerY,a.pointerX,a.pointerY,a.ctrlKey,a.altKey,a.shiftKey,a.metaKey,a.button,e)}e.dispatchEvent(u)}else{a.clientX=a.pointerX;a.clientY=a.pointerY;u=document.createEventObject();u=extend(u,a);e.fireEvent("on"+t,u)}}`

values = (object) ->
    Object.keys(object).map (key) -> object[key]

getElement = (selector) ->
    document.getElementById(selector) or
    document.getElementsByClassName(selector)[0]

pageHasAllButtons = (page) ->
    return values(page).reduce (allButtonsExist, elementName) ->
        if DEBUG
            alert elementName
            alert getElement(elementName)
        allButtonsExist and Boolean getElement elementName
    , true

playButtonExists = (page) ->

LOCATION = window.location.hostname

alert LOCATION if DEBUG

groovesharkElements =
    play: 'play-pause'
    forward: 'play-next'
    back: 'play-prev'
rdioElements =
    play:  'play_pause'
    forward: 'next'
    back: 'prev'
youtubeElements =
    play: do ->
        playClass = 'html5-play-button'
        pauseClass = 'html5-pause-button'
        check = getElement playClass
        if check then playClass else pauseClass
    forward: 'watch7-playlist-bar-next-button'
    back: 'watch7-playlist-bar-prev-button'

elements =
    'grooveshark.com': groovesharkElements
    'www.grooveshark.com': groovesharkElements
    'rdio.com': rdioElements
    'www.rdio.com': rdioElements
    'youtube.com': youtubeElements
    'www.youtube.com': youtubeElements

checkPage = ->
    currentPageElements = elements[LOCATION]
    Boolean getElement currentPageElements.play ||
    currentPageElements.forward ||
    currentPageElements.back ||
#TODO: youtube neccessitates lots of error checking, like if it decides
#to turn back into flash (maybe some videos are just all flash)
#we may also be able to grab non-play buttons (just a thought, may not too)
unless checkPage()
    return

alert 'woot did not abort' if DEBUG

#TODO: everything loads in grooveshark but may not actually bind to anything,
#nothing loads automatically in rdio but things are definitely bound to where
#they need to be

click = (element) -> fireEvent(element, 'click')

#TODO: functionality needed: grabbing dom elements (may be built into dude's fireEvent function,
    #but if not, simple enough, just need to confirm youtube's elements use ids as well)

Mediakeys = {}

findDOMelements = (domain) ->
    DOMelements = {}
    for mediaKey, domID of elements[domain]
        DOMelements[mediaKey] = getElement domID
    return DOMelements

bindSingleKeyFunction = (mediaKey, domElement) ->
    Mediakeys[mediaKey] = -> click(domElement)

bindKeyFunctions = (DOMelements) ->
    for mediaKey, domElement of DOMelements
        bindSingleKeyFunction mediaKey, domElement

Mediakeys.init = (domain) ->
    DOMelements = findDOMelements domain
    bindKeyFunctions DOMelements
    return Mediakeys

window.Mediakeys = Mediakeys.init LOCATION



