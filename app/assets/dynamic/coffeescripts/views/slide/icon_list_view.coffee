class SlideIconListView extends Backbone.View
  tagName: 'ul'

  className: 'slide-list'

  initialize: ->
    @render()
    D.Slides.on 'reset',  @render, this
    D.Slides.on 'change', @render, this
    D.Slides.on 'change:order', D.Slides.fetch

  render: ->
    return unless D.Slides.models

    @$el.empty()

    _.each(D.Slides.models, (slide) =>
      iconView = new D.SlideIconView
        model:        slide
        isFirstSlide: @isFirstSlide(slide)
        isLastSlide:  @isLastSlide(slide)

      @$el.append(iconView.el)
      iconView.render()
    )

  isFirstSlide: (slide) ->
    slide.get('number') == 1

  isLastSlide: (slide) ->
    slide.get('number') == D.Slides.length

@D = window.D || {}
@D.SlideIconListView = SlideIconListView
