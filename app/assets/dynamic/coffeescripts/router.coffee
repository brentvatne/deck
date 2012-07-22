class Router extends Backbone.Router
  routes:
    "":               "root"
    "decks":          "home"
    "decks/new":      "deckNew"
    "decks/:id/edit": "deckEdit"

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

  initializeAppView: ->
    @appView = new da.views.AppView
      preloadData: da.preloadData

@da = window.da
@da.Router = Router
