window.app or= {}

$ ->
	do Backbone.history.start
	do (new app.GlobalView()).initilize
