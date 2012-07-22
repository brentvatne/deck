class LoadingNotificationView extends Backbone.View

  tagName: 'LoadingNotification'

  template: _.template($('#loading-notification-template').html())

  initialize: ->
    @render()

  render: ->
    @$el.html(@template())

@D = window.D     || {}
@D.Util = @D.Util || {}
@D.Util.LoadingNotificationView = LoadingNotificationView
