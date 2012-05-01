class Router extends Backbone.Router
  routes:
    "":      "home"
    ":variable": "someVariableAction"

  home: ->
    @initializeAppView

  someVariableAction: (variableIsPassedHere) ->
    # do something with the variable

  initializeAppView: ->
    unless @appView
      @appView = new Deck.AppView
        collection: Deck.Things
        preloadData: Deck.preloadData

@Deck = window.Deck || {}
@Deck.Router = Router
