class DeckNewView extends Backbone.View
  className: 'new-deck'

  template: _.template($('#deck-new-template').html())

  events:
    'submit form': 'createNewDeck'

  initialize: ->
    @render()

  render: ->
    @$el.html(@template())
    @nameField = @$el.find('.deck-name-input')
    @submitButton = @$el.find('.submit-button')

  createNewDeck: (e) ->
    e.preventDefault()

    if @nameIsBlank()
      @displayInvalidNameError()
    else
      @saveNewDeck(@nameField.val())

  saveNewDeck: (name) ->
    @deck = new da.models.Deck
    @deck.save name: name,
      success: _.bind(@navigateToEdit, this)
      error:   _.bind(@displayServerError, this)

  navigateToEdit: ->
    @displaySuccessNotification()
    Backbone.history.navigate("/decks/#{@deck.get('id')}/edit", true)

  displaySuccessNotification: ->
    da.ui.displayNotification
      type:    'success'
      message: 'Your new deck has been created'

  displayInvalidNameError: ->
    da.ui.vibratePaper()
    da.ui.displayNotification
      type:    'error'
      message: 'You can\'t leave the name blank! Please provide one'

  displayServerError: ->
    da.ui.displayNotification
      type:    'error'
      message: 'Something went wrong on the server, try again in a few minutes.'

  nameIsBlank: ->
    @nameField.val() == ""

@da = window.da
@da.views.DeckNewView = DeckNewView
