class AppView extends Backbone.View
  class: 'deck-app-wrap'

  template: _.template($('#deck-app-template').html())

  events:
    "click .navigate-home": "home"

  initialize: ->
    @preloadData = @options['preloadData']
    @render()

  render: ->
    $('#deck').empty()
    $('#deck').append(@el)

    @$el.append(@template
      currentUserEmail: @preloadData.currentUserEmail)

    @renderDeckIndex()

  renderDeckIndex: ->
    indexView = new DeckApp.DeckIndexView(collection: @collection)
    @appContentContainer().append(indexView.el)

  appContentContainer: ->
    @$el.find(".paper")

  home: (e) ->
    e?.preventDefault()
    Backbone.history.navigate('decks', true)

@DeckApp = window.DeckApp || {}
@DeckApp.AppView = AppView
