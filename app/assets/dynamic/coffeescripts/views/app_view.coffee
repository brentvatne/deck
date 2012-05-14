class AppView extends Backbone.View
  class: 'deck-app-wrap'

  template: _.template($('#deck-app-template').html())

  events:
    "click .navigate-home":  "navigateHome"
    "click .deck-show-link": "navigateToDeckAction"
    "click .new-deck-link":  "navigateToDeckAction"

  initialize: ->
    @preloadData = @options['preloadData']
    @render()

  render: ->
    $('#deck').empty()
    $('#deck').append(@el)

    @$el.append(@template
      currentUserEmail: @preloadData.currentUserEmail)

  showDeckIndex: ->
    @appContentContainer().empty()

    indexView = new DeckApp.DeckIndexView(collection: @collection)
    @appContentContainer().append(indexView.el)

  showDeckNew: ->
    @appContentContainer().empty()
    @appContentContainer().html('new')

  showDeckEdit: (id) ->
    @appContentContainer().empty()
    @appContentContainer().html("edit #{id}")

  navigateHome: (e) ->
    e.preventDefault()
    Backbone.history.navigate('decks', true)

  navigateToDeckAction: (e) ->
    e.preventDefault()
    path = $(e.currentTarget).attr('href')
    Backbone.history.navigate(path, true)

  appContentContainer: -> @$el.find(".paper")

@DeckApp = window.DeckApp || {}
@DeckApp.AppView = AppView
