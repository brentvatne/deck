class Router extends Backbone.Router
  routes:
    "decks":     "home"
    "decks/:id": "edit"

  home: ->
    @initializeAppView()

  edit: (id) ->
    alert id
    # do something with the variable

  initializeAppView: ->
    @appView = new DeckApp.AppView
      preloadData: DeckApp.preloadData

@DeckApp = window.DeckApp || {}
@DeckApp.Router = Router
