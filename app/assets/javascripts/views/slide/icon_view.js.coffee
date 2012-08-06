class SlideIconView extends Backbone.View
  tagName: 'li'

  className: 'micro-slide'

  events:
    'click .slide-edit-button':   'editSlide'
    'click .slide-delete-button': 'deleteSlide'

  template: JST['templates/slide/icon']

  initialize: (options) ->
    da.app.instances.slideIconViews.push(this)

    @slide = options.slide
    @slide.on 'change', @render, this

    @render()

  render: ->
    @$el.html @template(@slide.toJSON())
    @$el.attr 'data-id', @slide.get('id')

    da.ui.highlightCodeBlock(@$el)

  editSlide: (e) ->
    e.preventDefault()
    deckID  = @slide.get('deck_id')
    slideID = @slide.get('id')

    Backbone.history.navigate(
      "/decks/#{deckID}/slides/#{slideID}/edit"
    , true)

  deleteSlide: (e) ->
    @remove()
    @slide.destroy
      error: @displayDestroyFailedError

    e.preventDefault()
    e.stopPropagation()

  displayDestroyFailedError: ->
    da.ui.displayNotification
      type:    'error'
      message: 'Uh oh that didnt work :( Try again!'

@da = window.da
@da.views.SlideIconView = SlideIconView
