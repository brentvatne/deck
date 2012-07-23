class EmptySlideListView extends Backbone.View
  tagName: 'div'

  className: 'notice inline-notification'

  template: _.template($('#empty-slide-list-template').html())

  initialize: (options) ->
    da.app.instances.emptySlideListView = this

    @deckID = options.deckID
    @render()

  render: ->
    @$el.html(@template(deckID: @deckID))

@da = window.da
@da.views.EmptySlideListView = EmptySlideListView
