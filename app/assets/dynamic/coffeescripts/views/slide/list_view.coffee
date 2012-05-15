class SlideListView extends Backbone.View

  template: _.template($('#slide-list-template').html())

  initialize: ->
    @collection.on 'reset',  @render, this
    @collection.on 'change', @render, this

  render: ->
    @$el.html(@template
      numberOfSlides: @collection.length
      deckID:         @collection.deckID
    )
    @renderIcons()

  renderIcons: ->
    _.each(@collection.models, (slide) =>
      iconView = new DeckApp.SlideIconView
        model:        slide
        deckID:       @collection.deckID
        isFirstSlide: @isFirstSlide(slide)
        isLastSlide:  @isLastSlide(slide)

      @$el.find('.slide-list').append(iconView.el)
      iconView.render()
    )

  isFirstSlide: (slide) ->
    slide.get('number') == 1

  isLastSlide: (slide) ->
    slide.get('number') == @numberOfSlides()

  numberOfSlides: ->
    @collection.length

@DeckApp = window.DeckApp || {}
@DeckApp.SlideListView = SlideListView
