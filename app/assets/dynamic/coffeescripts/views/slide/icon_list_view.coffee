class SlideIconListView extends Backbone.View
  tagName: 'ul'

  className: 'slide-list'

  initialize: ->
    da.app.instances.slideIconListView = this

    @slides = @collection
    @slides.on 'reset',        @render,       this
    @slides.on 'change:order', @slides.fetch, @slides

    @render()

  render: ->
    return unless @slides.models

    @$el.empty()

    _.each(@slides.models, (slide) =>
      slide.on 'change:order', @render, this

      iconView = new da.views.SlideIconView
        slide:        slide
        isFirstSlide: @isFirstSlide(slide)
        isLastSlide:  @isLastSlide(slide)

      @$el.append iconView.el
    )

  isFirstSlide: (slide) ->
    slide.get('number') == 1

  isLastSlide: (slide) ->
    slide.get('number') == @slides.length

@da = window.da
@da.views.SlideIconListView = SlideIconListView
