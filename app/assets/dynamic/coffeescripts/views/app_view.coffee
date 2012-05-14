class AppView extends Backbone.View
  class: 'deck-app-wrap'

  template: _.template($('#deck-app-template').html())

  initialize: ->
    @preloadData = @options['preloadData']
    @render()

  render: ->
    @emptyAppViewContainer()
    @addAppViewElementToContainer()
    @renderAppViewTemplate()

  emptyAppViewContainer: ->
    $('#deck').empty()

  addAppViewElementToContainer: ->
    $('#deck').append(@el)

  renderAppViewTemplate: ->
    @$el.append(@template
      someVariable: "hello world"
      currentUserEmail: @preloadData.currentUserEmail)

  events:
    "click .navigate-home": "home"

  home: (e) ->
    e?.preventDefault()
    Backbone.history.navigate('decks', true)

@DeckApp = window.DeckApp || {}
@DeckApp.AppView = AppView
