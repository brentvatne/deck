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
    unless @appView
      @appView = new DeckApp.AppView

@DeckApp = window.DeckApp || {}
@DeckApp.Router = Router
