class AppView extends Backbone.View
  class: 'deck-app-wrap'

  template: JST['templates/app']

  events:
    "click .navigate-home":    "navigateHome"
    "click .deck-show-button": "navigateToDeckAction"
    "click .new-deck-button":  "navigateToDeckAction"

  initialize: (options) ->
    preloadData = options['preloadData']

    da.app = this
    @currentUser = new da.models.CurrentUser(email: preloadData.currentUserEmail)

    @render()

  render: ->
    $('#deck').empty()
    $('#deck').append(@el)

    @$el.append @template(currentUserEmail: @currentUser.get('email'))

    @$content = @$el.find(".paper")

  showDeckIndex: ->
    @clearContainers()

    @content = new da.views.DeckIndexView
    @$content.append(@content.el)

  showDeckNew: ->
    @clearContainers()

    @content = new da.views.DeckNewView
    @$content.append(@content.el)

  showDeckEdit: (id) ->
    @clearContainers()

    @content = new da.views.DeckEditView(deckID: id)
    @$content.append(@content.el)

  showSlideEdit: (deckID, slideID) ->
    if @content?.editSlide
      @content.editSlide(slideID)
    else
      @clearContainers()
      @content = new da.views.DeckEditView(deckID: deckID, slideID: slideID)
      @$content.append(@content.el)

  showPresentation: (deckID, slideID) ->
    @clearContainers()
    @content = new da.views.PresentationView(deckID: deckID, slideID: slideID)
    @$content.append(@content.el)

  navigateHome: (e) ->
    e.preventDefault()
    Backbone.history.navigate('decks', true)

  navigateToDeckAction: (e) ->
    e.preventDefault()
    path = $(e.currentTarget).attr('href')
    Backbone.history.navigate(path, true)

  clearContainers: ->
    @$content.empty()
    @instances = {}

@da = window.da
@da.views.AppView = AppView
