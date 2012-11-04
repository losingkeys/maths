window.app or= {}

$ ->
	console.log do Backbone.history.start
	do (new app.GlobalView()).initilize
