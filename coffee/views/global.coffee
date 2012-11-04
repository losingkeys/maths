window.app or= {}

GlobalView = Backbone.View.extend
	el: 'body'

	initilize: ->
		console.log 'init global view'

	events:
		'click #config': 'renderConfig'
		'click #reset': 'nav'
		'click nav': 'nav'

	renderConfig: ->
		console.log 'rendering config page'

	nav: ->
		console.log 'navigating'

window.app.GlobalView = GlobalView
