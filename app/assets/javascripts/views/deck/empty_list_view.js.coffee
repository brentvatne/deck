class EmptyDeckListView extends Backbone.View
  tagName: 'div'

  className: 'notice inline-notification'

  template: JST['templates/deck/empty_list']

  initialize: ->
    da.app.instances.emptyDeckListView = this
    @render()

  render: ->
    @$el.html @template()

@da = window.da
@da.views.EmptyDeckListView = EmptyDeckListView
