class Router extends Backbone.Router
  routes:
    "decks": "home"

  home: ->
    @initializeAppView()

  initializeAppView: ->
    unless @appView
      @appView = new DeckApp.AppView
    #    collection: DeckApp.Decks
    #    preloadData: DeckApp.preloadData

  someVariableAction: (variableIsPassedHere) ->
    # do something with the variable

@DeckApp = window.DeckApp || {}
@DeckApp.Router = Router
