class Router extends Backbone.Router
  routes:
    "decks":     "home"
    "decks/:id": "edit"

  home: ->
    @initializeAppView()
    @appView.collection.fetch()

  edit: (id) ->
    alert id

  initializeAppView: ->
    @appView = new DeckApp.AppView
      preloadData: DeckApp.preloadData
      collection: DeckApp.Decks

@DeckApp = window.DeckApp || {}
@DeckApp.Router = Router
