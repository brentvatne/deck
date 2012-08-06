//= require           ./vendor/jquery
//= require           ./vendor/underscore
//= require_directory ./vendor

//= require_tree ./templates
//= require_tree ./models
//= require_tree ./collections
//= require_tree ./views
//= require_directory .

$ ->
  new da.Router
  Backbone.history.start pushState: true
