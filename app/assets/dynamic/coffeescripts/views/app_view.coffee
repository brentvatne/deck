class AppView extends Backbone.View
  class: 'deck-app-wrap'

  template: _.template($('#deck-app-template').html())

  events:
    "click .navigate-home":  "navigateHome"
    "click .deck-show-link": "navigateToDeckAction"
    "click .new-deck-link":  "navigateToDeckAction"

  initialize: (options) ->
    preloadData = options['preloadData']

    da.app = this
    @content     = {}
    @currentUser = new da.models.CurrentUser(email: preloadData.currentUserEmail)

    @render()

  render: ->
    $('#deck').empty()
    $('#deck').append(@el)

    @$el.append @template(currentUserEmail: @currentUser.get('email'))

    @$content = @$el.find(".paper")

  showDeckIndex: ->
    @$content.empty()

    @content = new da.views.DeckIndexView
    @$content.append(@content.el)

  showDeckNew: ->
    @$content.empty()

    @content = new da.views.DeckNewView
    @$content.append(@content.el)

  showDeckEdit: (id) ->
    @$content.empty()

    @content = new da.views.DeckEditView(id: id)
    @$content.append(@content.el)

  navigateHome: (e) ->
    e.preventDefault()
    Backbone.history.navigate('decks', true)

  navigateToDeckAction: (e) ->
    e.preventDefault()
    path = $(e.currentTarget).attr('href')
    Backbone.history.navigate(path, true)

@da = window.da
@da.views.AppView = AppView
