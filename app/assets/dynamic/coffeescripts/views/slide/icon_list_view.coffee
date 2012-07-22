class SlideIconListView extends Backbone.View
  tagName: 'ul'

  className: 'slide-list'

  initialize: ->
    @render()
    da.app.slides.on 'reset',  @render, this
    da.app.slides.on 'change:order', da.app.slides.fetch

  render: ->
    return unless da.app.slides.models

    @$el.empty()

    _.each(da.app.slides.models, (slide) =>
      iconView = new da.views.SlideIconView
        model:        slide
        isFirstSlide: @isFirstSlide(slide)
        isLastSlide:  @isLastSlide(slide)

      @$el.append(iconView.el)
      iconView.render()
    )

  isFirstSlide: (slide) ->
    slide.get('number') == 1

  isLastSlide: (slide) ->
    slide.get('number') == da.app.slides.length

@da = window.da
@da.views.SlideIconListView = SlideIconListView
