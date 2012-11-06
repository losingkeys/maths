window.app or= {}

GlobalView = Backbone.View.extend
	el: 'body'

	events:
		'click #config': 'renderConfig'
		'click #reset': 'nav'
		'click nav': 'nav'

	renderConfig: ->
		# pass

	nav: ->
		# pass

window.app.GlobalView = GlobalView
