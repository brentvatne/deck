class LoadingNotificationView extends Backbone.View

  tagName: 'LoadingNotification'

  template: _.template($('#loading-notification-template').html())

  initialize: ->
    @render()

  render: ->
    @$el.html(@template())

@da = window.da
@da.ui = @da.ui || {}
@da.ui.LoadingNotificationView = LoadingNotificationView
