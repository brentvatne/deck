class EmptyDeckListView extends Backbone.View
  tagName: 'div'

  className: 'notice inline-notification'

  template: _.template($('#empty-deck-list-template').html())

  initialize: ->
    da.app.instances.emptyDeckListView = this
    @render()

  render: ->
    @$el.html @template()

@da = window.da
@da.views.EmptyDeckListView = EmptyDeckListView
