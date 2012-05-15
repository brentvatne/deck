class DeckEditView extends Backbone.View
  class: 'deck-edit-wrap'

  template: _.template($('#deck-edit-template').html())

  initialize: ->
    @model = new DeckApp.Deck(id: @options.id)
    @model.fetch
      success: @render.bind(this)
      error:   @invalidID.bind(this)

    # instantiate new slides collection
    # set the url to according to the id of @model
    # fetch it

  render: ->
    @$el.html(@template(@model.toJSON()))

    # render slide list

  invalidID: (model, response) ->
    DeckApp.Util.displayNotification
      type:    'error'
      message: "A deck with an id of #{model.get('id')} does not exist, " +
               "or is inaccessible to you for editing."
    Backbone.history.navigate('decks', true)

@DeckApp = window.DeckApp || {}
@DeckApp.DeckEditView = DeckEditView
