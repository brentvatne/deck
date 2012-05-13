class AppView extends Backbone.View
  class: 'deck-app-wrap'

  template: _.template($('#deck-app-view-template').html())

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
    @$el.append(@template())
    #@$el.append(@template(a_variable: "hello"))

  events:
    "click a": "doAThing"

  doAThing: (e) ->
    e?.preventDefault()
    alert 'clicked'
    #Backbone.history.navigate('some-new-path')

@DeckApp = window.DeckApp || {}
@DeckApp.AppView = AppView
