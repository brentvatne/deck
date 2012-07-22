class SlideIconListView extends Backbone.View
  tagName: 'ul'

  className: 'slide-list'

  initialize: ->
    da.app.instances.slideIconListView = this
    da.app.instances.slideIconViews    = []

    @slides = @collection
    @slides.on 'reset',        @render,       this
    @slides.on 'change:order', @slides.fetch, @slides

    @render()

  render: ->
    @$el.empty()

    _.each @slides.models, (slide) =>
      slide.on 'change:order', @render, this
      @$el.append (new da.views.SlideIconView(slide: slide)).el

@da = window.da
@da.views.SlideIconListView = SlideIconListView
