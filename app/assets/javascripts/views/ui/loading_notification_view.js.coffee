class LoadingNotificationView extends Backbone.View

  tagName: 'LoadingNotification'

  template: JST['templates/ui/loading_notification']

  initialize: ->
    @render()

  render: ->
    @$el.html(@template())

@da = window.da
@da.ui = @da.ui || {}
@da.ui.LoadingNotificationView = LoadingNotificationView
