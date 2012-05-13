class AppView extends Backbone.View
  class: 'deck-app-wrap'

  #template: _.template($('#deck-app-view-template').html())

  initialize: ->
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
    @$el.append("hello world")
    #@$el.append(@template(some_variable: "hello world"))

  events:
    "click a": "doAThing"

  doAThing: (e) ->
    e?.preventDefault()
    alert 'clicked'
    #Backbone.history.navigate('decks/new deck id', true)

@DeckApp = window.DeckApp || {}
@DeckApp.AppView = AppView
