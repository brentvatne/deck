class SlideIconListView extends Backbone.View

  template: _.template($('#slide-list-template').html())

  initialize: ->
    @collection.on 'reset',  @render, this
    @collection.on 'change', @render, this

  reloadSlides: ->
    @collection.fetch()

  render: ->
    @$el.html(@template
      numberOfSlides: @collection.length
      deckID:         @collection.deckID
    )
    @renderIcons()

  renderIcons: ->
    _.each(@collection.models, (slide) =>
      slide.on 'sync', @reloadSlides, this

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
    slide.get('number') == @collection.length

@DeckApp = window.DeckApp || {}
@DeckApp.SlideIconListView = SlideIconListView
