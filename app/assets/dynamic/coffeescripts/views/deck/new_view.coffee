class DeckNewView extends Backbone.View
  className: 'new-deck'

  template: _.template($('#deck-new-template').html())

  events:
    'submit form': 'createNewDeck'

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
    @deck = new DeckApp.Deck
    @deck.save name: name,
      success: _.bind(@navigateToEdit, this)
      error:   _.bind(@displayServerError, this)

  navigateToEdit: ->
    @displaySuccessNotification()
    Backbone.history.navigate("/decks/#{@deck.get('id')}/edit", true)

  displaySuccessNotification: ->
    DeckApp.Util.displayNotification
      type:    'success'
      message: 'Your new deck has been created'

  displayInvalidNameError: ->
    DeckApp.Util.vibratePaper()
    DeckApp.Util.displayNotification
      type:    'error'
      message: 'You can\'t leave the name blank! Please provide one'

  displayServerError: ->
    DeckApp.Util.displayNotification
      type:    'error'
      message: 'Something went wrong on the server, try again in a few minutes.'

  nameIsBlank: ->
    @nameField.val() == ""

@DeckApp = window.DeckApp || {}
@DeckApp.DeckNewView = DeckNewView
