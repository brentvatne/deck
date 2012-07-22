ui =
  showLoading: ->
    @loadingNotification = new da.ui.LoadingNotificationView
    $('.paper').append(@loadingNotification.el)

  hideLoading: ->
    @loadingNotification?.remove()

  vibratePaper: ->
    @vibrateElement $('#deck .paper')

  vibrateElement: (element) ->
    element.jrumble(x: 6, y: 0, rotation: 0, speed: 22)
    element.trigger('startRumble')
    setTimeout ( =>
      element.trigger('stopRumble')
    ), 300

  # Public: Adds a notification to the body.
  #
  # options - An object literal that describes the notification
  #           type    - Is it an error or a notice? eg 'error' 'notice'
  #           message - What do you want to say? eg 'Could not find the thing'
  #
  # No useful return value, purely side effects
  displayNotification: (options) ->
    @removeAnyNotifications()
    new_notification = @renderNotification(options)
    $('body').prepend new_notification
    $('body').find('.notification').delay(3500).slideUp(600)

  removeAnyNotifications: ->
    $('body .notification').remove()

  renderNotification: (params) ->
    notification_template = _.template($('#notification-template').html())
    notification_template(params)

  highlightCodeBlock: (block) ->
    codeBlocks = block.find('pre code')
    if codeBlocks
      codeBlocks.each (i, e) -> hljs.highlightBlock(e)

@da = window.da || {}
@da.ui = _.extend(@da.ui, ui)
