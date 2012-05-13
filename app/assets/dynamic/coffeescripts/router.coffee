class Router extends Backbone.Router
  routes:
    "decks":     "home"
    "decks/:id": "edit"

  home: ->
    alert 'hello world'
    #@initializeAppView()

  edit: (id) ->
    alert id
    # do something with the variable

  initializeAppView: ->
    #unless @appView
      #@appView = new DeckApp.AppView
    #    collection: DeckApp.Decks
    #    preloadData: DeckApp.preloadData


@DeckApp = window.DeckApp || {}
@DeckApp.Router = Router
