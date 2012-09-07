class Router extends Backbone.Router
  routes:
    "":                                   "root"
    "decks":                              "home"
    "decks/new":                          "deckNew"
    "decks/:id/edit":                     "deckEdit"
    "decks/:deckID/slides/:slideID/edit": "slideEdit"
    "decks/:deckID/present/:slideID":     "present"

  root: ->
    Backbone.history.navigate("decks", true)

  home: ->
    @initializeAppView() unless @appView
    @appView.showDeckIndex()

  deckNew: ->
    @initializeAppView() unless @appView
    @appView.showDeckNew()

  deckEdit: (id) ->
    @initializeAppView() unless @appView
    @appView.showDeckEdit(id)

  slideEdit: (deckID, slideID) ->
    @initializeAppView() unless @appView
    @appView.showSlideEdit(deckID, slideID)

  present: (deckID, slideID) ->
    @initializeAppView() unless @appView
    @appView.showPresentation(deckID, slideID)

  initializeAppView: ->
    @appView = new da.views.AppView
      preloadData: da.preloadData

@da = window.da
@da.Router = Router
